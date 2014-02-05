use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Role::Bundle;

# ABSTRACT: Base mechanics for a Bundle

# AUTHORITY

use Moo::Role 1.000008;

use Perl::Critic::ProfileCompiler::Util qw( create_pseudoaction );

# Literal config is the unmodifed configuration prior to inlining.
has 'literal_config' => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    return [];
  },
);

has 'compiler' => (
  is   => ro =>,
  lazy => 1,
);

requires 'configure';

sub register_component {
  my ( $self, $compiler ) = @_;

}

sub _add_literal_instruction {
  my ( $self, $instruction_name, %instruction ) = @_;
  push @{ $self->literal_config }, create_pseudoaction( $instruction_name, %instruction );
}

sub append_bundle {
  my ( $self, $bundle_name, %parameters ) = @_;
  my $bundle_instance;
  if ( $self->compiler ) {
    $bundle_instance = $self->compiler->load_bundle( $bundle_name, %parameters );
  }
  $self->_add_literal_instruction(
    'append_bundle' => (
      bundle     => $bundle_name,
      parameters => {%parameters},
      ( defined $bundle_instance ? ( bundle_contents => $bundle_instance->literal_config ) : () )
    )
  );
}

# Find $plugin_name
#
# If it exists:
#   Nuke it, and use this new configuration
# Otherwise:
#   Vivify $plugin_name with the provided configuration
#
sub add_or_replace_plugin {
  my ( $self, $plugin_name, %parameters ) = @_;
  $self->_add_literal_instruction(
    'add_or_replace_plugin' => (
      plugin     => $plugin_name,
      parameters => {%parameters},
    )
  );
}

# Find $plugin_name
#
# If it exists:
#   find $field
#       if it exists:
#           replace its value with $value
#       if it doesn't exist:
#           set its value to $value
#
# If it doesn't exist:
#   vivify it
#       set the value of $field to $value
sub add_or_replace_plugin_field {
  my ( $self, $plugin_name, $field, $value ) = @_;
  $self->_add_literal_instruction(
    'add_or_replace_plugin_field' => (
      plugin => $plugin_name,
      field  => $field,
      value  => $value,
    )
  );
}

sub add_or_append_plugin_field {
  my ( $self, $plugin_name, $field, $value ) = @_;
  $self->_add_literal_instruction(
    'add_or_append_plugin_field' => (
      plugin => $plugin_name,
      field  => $field,
      value  => $value,
    )
  );
}

sub remove_plugin {
  my ( $self, $plugin_name ) = @_;
  $self->_add_literal_instruction(
    'remove_plugin' => (
      plugin => $plugin_name,
    )
  );
}

no Moo;
1;

