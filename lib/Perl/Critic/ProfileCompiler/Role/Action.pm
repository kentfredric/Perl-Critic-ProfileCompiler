use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Role::Action;
$Perl::Critic::ProfileCompiler::Role::Action::VERSION = '0.001000';
# ABSTRACT: Basic interface spec for Action objects

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moo::Role;

has action_name => (
  is      => ro =>,
  lazy    => 1,
  builder => 1,
);

has ':definition_context' => (
  is   => ro =>,
  lazy => 1,
  default => sub { return {} },
);

sub _build_action_name {
  my ($self) = @_;
  require Scalar::Util;
  my $class = blessed($self);
  if ( $class =~ /^Perl::Critic::ProfileCompiler::Action::(.+)$/ ) {
    return "$1";
  }
  return $class;
}

sub _inline {
  my ( $self, $stack ) = @_;
  my $clone = [@$stack];
  if ( not $self->can('inline') ) {
    push @{$clone}, $self;
    return $clone;
  }
  return $self->inline($stack);
}

sub _apply {
  my ( $self, $config ) = @_;
  return $config unless $self->can('apply');
  return $self->apply($config);
}

no Moo::Role;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::Role::Action - Basic interface spec for Action objects

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
