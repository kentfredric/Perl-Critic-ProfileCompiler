use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Role::Bundle::Simple;

# ABSTRACT: A role for bundles that are just collections to policies with no advanced mechanics

# AUTHORITY

use Moo::Role;

with 'Perl::Critic::ProfileCompiler::Role::Bundle';

requires 'policies';

sub configure {
  my ($self) = @_;
  for my $policy ( $self->policies ) {
    $self->add_or_replace_policy($policy);
  }
}

no Moo::Role;
1;

