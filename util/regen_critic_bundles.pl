#!/usr/bin/env perl
# FILENAME: regen_critic_bundles.pl
# CREATED: 02/05/14 17:08:05 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Generate Bundles from PERL5LIB

use 5.018;
use feature 'lexical_subs';
use strict;
use warnings;
use utf8;
use Path::Tiny qw(path);

sub get_meta_dirs {

  use Config;

  my $arch = $Config{archname};

  my @out;

  for my $dir ( keys %Config ) {
    my $value = $Config{$dir};
    next unless $dir =~ /libexp/;
    next unless defined $value;
    next unless length $value;
    my $d = path($value);
    if ( -e ( my $p = $d->child('.meta') ) ) {
      push @out, $p;
    }
    if ( -e ( my $p = $d->child($arch)->child('.meta') ) ) {
      push @out, $p;
    }
  }
  return @out;
}

sub get_dir_bundles {
  my ($dir) = @_;
  my @out;
  for my $child ( $dir->children() ) {
    next unless $child->basename =~ /^Perl-Critic-/;
    next if $child->basename =~ /^Perl-Critic-Policy-/;
    push @out, $child;
  }
  return @out;
}

sub get_json_from_dist {
  my ($dir) = @_;
  require JSON;
  state $job = do { JSON->new };
  my $out = {};
  if ( -e $dir->child('MYMETA.json') ) {
    $out->{mymeta} = $job->decode( $dir->child('MYMETA.json')->slurp_utf8 );
  }
  if ( -e $dir->child('install.json') ) {
    $out->{install} = $job->decode( $dir->child('install.json')->slurp_utf8 );
  }
  return $out;
}

sub get_dist_name_from_json {
  my ($json) = @_;
  my $name = undef;
  if ( exists $json->{mymeta} and exists $json->{mymeta}->{name} ) {
    return $json->{mymeta}->{name};
  }
  elsif ( exists $json->{install} and exists $json->{install}->{name} ) {
    return $json->{install}->{name};
  }
}

sub mutate_dist_name_to_bundle_name {
  my ($distname) = @_;
  return if not $distname;
  return 'Core' if $distname eq 'Perl-Critic';
  return unless $distname =~ /^Perl-Critic-/;
  $distname =~ s/^Perl-Critic-//;
  $distname =~ s/-/::/g;
  return $distname;
}

sub json_has_policies {
  my ($json) = @_;
  if ( exists $json->{mymeta} and exists $json->{mymeta}->{provides} ) {
    for my $key ( keys %{ $json->{mymeta}->{provides} } ) {
      return 1 if $key =~ /^Perl::Critic::Policy::/;
    }
  }
  if ( exists $json->{install} and exists $json->{install}->{provides} ) {
    for my $key ( keys %{ $json->{install}->{provides} } ) {
      return 1 if $key =~ /^Perl::Critic::Policy::/;
    }
  }
  return;
}

sub get_bundle_version_from_json {
  my ($json) = @_;
  if ( exists $json->{mymeta} and exists $json->{mymeta}->{version} ) {
    return $json->{mymeta}->{version};
  }
  elsif ( exists $json->{install} and exists $json->{install}->{version} ) {
    return $json->{install}->{version};
  }
  return;
}

sub get_policies_from_json {
  my ($json) = @_;
  my %policies;
  if ( exists $json->{mymeta} and exists $json->{mymeta}->{provides} ) {
    for my $key ( keys %{ $json->{mymeta}->{provides} } ) {
      next unless $key =~ /^Perl::Critic::Policy::/;
      $key =~ s/^Perl::Critic::Policy:://;
      $policies{$key} = 1;
    }
  }
  elsif ( exists $json->{install} and exists $json->{install}->{provides} ) {
    for my $key ( keys %{ $json->{install}->{provides} } ) {
      next unless $key =~ /^Perl::Critic::Policy::/;
      $key =~ s/^Perl::Critic::Policy:://;
      $policies{$key} = 1;
    }
  }
  return keys %policies;
}

sub write_bundle {
  my (%config) = @_;

  my $indent;
  my $fh = $config{outfile}->openw;

  my sub p($) {
    print {$fh} ( ' ' x $indent ) if $indent;
    print {$fh} $_[0] . "\n";
  }

  p 'use 5.008;    # utf8';
  p 'use strict;';
  p 'use warnings;';
  p 'use utf8;';
  p '';
  p 'package ' . $config{bundlename} . ';';
  p '';
  p '# ABSTRACT: Profile Compiler Bundle for ' . $config{'distname'};
  p '# Based on version ' . $config{distversion};
  p '';
  p '# AUTHORITY';
  p '';
  p 'use Moo;';
  p '';
  p 'with \'Perl::Critic::ProfileCompiler::Role::Bundle::Simple\';';
  p '';
  p 'sub policies {';
  $indent += 2;
  p 'return qw(';
  $indent += 2;

  for my $policy ( sort @{ $config{policies} } ) {
    p $policy;
  }
  $indent -= 2;
  p ');';
  $indent -= 2;
  p '}';
  p '';
  p 'no Moo;';
  p '';
  p '1;';
}

my ($outdir) = @ARGV;

die "No outdir specified as \$1" if not defined $outdir;

for my $dir ( get_meta_dirs() ) {
  for my $bundle ( get_dir_bundles($dir) ) {
    my $json = get_json_from_dist($bundle);
    print "$bundle:\n";
    if ( not json_has_policies($json) ) {
      print " No Policies Found\n";
      next;
    }
    my $dist       = get_dist_name_from_json($json);
    my $bundle     = mutate_dist_name_to_bundle_name($dist);
    my $bundlename = 'Perl::Critic::ProfileCompiler::Bundle::' . $bundle;
    my $version    = get_bundle_version_from_json($json);
    my (@policies) = get_policies_from_json($json);
    print "  $dist\n";
    print "  - $bundlename\n";
    print "  v: $version\n";
    print "  p: " . ( join q[, ], @policies ) . "\n";

    my $root = path($outdir);
    $root->mkpath;

    my $outfile = $root->child( split /::/, $bundlename );
    $outfile = path( $outfile . '.pm' );
    $outfile->parent->mkpath;

    #    print "Would write $outfile\n";
    write_bundle(
      outfile     => $outfile,
      distname    => $dist,
      bundlename  => $bundlename,
      distversion => $version,
      policies    => \@policies,
    );
  }
}

