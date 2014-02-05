use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::add_or_replace_plugin_field;

# ABSTRACT: Forcibly make a given field visible for a given plugin.

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'plugin' => (
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

no Moo;

1;

