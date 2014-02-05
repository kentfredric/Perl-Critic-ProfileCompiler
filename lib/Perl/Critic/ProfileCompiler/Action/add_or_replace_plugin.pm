use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::add_or_replace_plugin;

# ABSTRACT: Forcibly make a new plugin appear with given configuration

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'plugin' => (
  is       => ro =>,
  required => 1,
);

has 'parameters' => (
  is      => ro  =>,
  lazy    => 1,
  builder => sub { {} },
);

no Moo;

1;

