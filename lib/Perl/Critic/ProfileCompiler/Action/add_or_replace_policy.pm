use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::add_or_replace_policy;

# ABSTRACT: Forcibly make a new policy appear with given configuration

# AUTHORITY

use Moo;
use Perl::Critic::ProfileCompiler::Util qw( expand_policy );

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'policy' => (
  is       => ro =>,
  required => 1,
);

has 'parameters' => (
  is      => ro  =>,
  lazy    => 1,
  builder => sub { {} },
);

sub apply {
  my ( $self, $config ) = @_;
  $config->add_policy( $self->policy, 1, %{ $self->parameters } );
  return $config;
}

sub own_deps {
  my ( $self, $deps ) = @_;
  $deps->{ expand_policy( $self->policy ) } = 0;
  return $deps;
}
no Moo;

1;

