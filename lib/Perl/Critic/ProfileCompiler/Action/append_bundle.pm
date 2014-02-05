use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::append_bundle;

# ABSTRACT: Inject a bundle of configuration into a parent configuration

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'bundle' => (
  is       => ro =>,
  required => 1,
);

has 'parameters' => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    return {};
  },
);

no Moo;

1;

