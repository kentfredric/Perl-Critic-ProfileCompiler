use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::add_or_replace_policy_field;

# ABSTRACT: Forcibly make a given field visible for a given policy.

# AUTHORITY

use Moo;

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
  my $p = $config->get_policy( $self->policy );
  $p->parameters->{ $self->field } = $self->value;
  return $config;
}
no Moo;

1;

