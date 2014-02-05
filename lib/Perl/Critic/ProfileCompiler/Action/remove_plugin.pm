use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::remove_plugin;

# ABSTRACT: Remove a plugin that is already added

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'plugin' => (
  is       => ro =>,
  required => 1,
);

no Moo;

1;

