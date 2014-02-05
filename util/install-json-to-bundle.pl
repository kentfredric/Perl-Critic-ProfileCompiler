#!/usr/bin/env perl
# FILENAME: install-json-to-bundle.pl
# CREATED: 02/05/14 05:00:00 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Convert a install.json file made my cpanm to a bundle

use strict;
use warnings;
use utf8;

use Path::Tiny;
use JSON;

my ($file) = path( $ARGV[0] );
my $json   = JSON->new();
my $data   = $json->decode( $file->slurp_utf8 );

my $basename;

if ( not $ARGV[1] ) {
  $basename = $data->{'name'};
  $basename =~ s/^Perl::Critic:://;
}
else {
  $basename = $ARGV[1];
}
my $package = 'Perl::Critic::ProfileCompiler::Bundle::' . $basename;
my @policies =
  map { $_ =~ s/^Perl::Critic::Policy:://; $_ } grep { $_ =~ /^Perl::Critic::Policy::/ } keys %{ $data->{'provides'} };

my $i = 0;
sub p($) { print( ' ' x $i ) if $i; print $_[0] . "\n" }

p 'use 5.008; # utf8';
p 'use strict;';
p 'use warnings;';
p 'use utf8;';
p '';
p 'package ' . $package . ';';
p '';
p '# ABSTRACT: Profile Compiler Bundle for ' . $data->{'name'};
p '';
p '# AUTHORITY';
p '';
p 'use Moo;';
p '';
p 'with \'Perl::Critic::ProfileCompiler::Role::Bundle::Simple\';';
p '';
p 'sub policies {';
$i += 2;
p 'return qw(';
$i += 2;

for my $policy ( sort @policies ) {
  p $policy;
}
$i -= 2;
p ');';
$i -= 2;
p '}';
p '';
p 'no Moo;';
p '';
p '1;';

