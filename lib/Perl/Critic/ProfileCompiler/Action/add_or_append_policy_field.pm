use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::add_or_append_policy_field;

# ABSTRACT: Forcibly make a given value appear in some field in a given policy.

# AUTHORITY

use Moo;
use Perl::Critic::ProfileCompiler::Util qw(expand_policy);

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'policy' => (
  is       => ro =>,
  required => 1,
);

has 'field' => (
  is       => ro =>,
  required => 1,
);

has 'value' => (
  is       => ro =>,
  required => 1,
);

sub apply {
  my ( $self, $config ) = @_;
  if ( not $config->has_policy( $self->policy ) or not $config->get_policy( $self->policy )->enabled ) {
    $config->add_policy( $self->policy, 1, $self->field, $self->value );
    return $config;
  }
  my $p  = $config->get_policy( $self->policy );
  my $fv = $p->parameters->{ $self->field };
  $fv .= ' ' if length $fv and $fv !~ / $/;
  $fv .= $self->value;
  $p->parameters->{ $self->field } = $fv;
  return $config;
}

sub own_deps {
  my ( $self, $deps ) = @_;
  $deps->{ expand_policy( $self->policy ) } = 0;
  return $deps;
}

no Moo;

1;

