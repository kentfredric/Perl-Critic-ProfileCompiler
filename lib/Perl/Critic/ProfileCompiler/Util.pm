use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Util;

# ABSTRACT: Misc Utility functions

# AUTHORITY

use Sub::Exporter::Progressive -setup => {
  exports => [
    qw( expand_bundle require_bundle create_bundle ),
    qw( require_policy expand_policy ),
    qw( expand_action require_action create_action ),
    qw( create_pseudoaction inflate_pseudoaction ),
    qw( sniff_action_caller ),
  ],
};

my $PREFIX = 'Perl::Critic::ProfileCompiler';

sub expand_bundle {
  my ($bundle) = @_;
  require Module::Runtime;
  return Module::Runtime::compose_module_name( $PREFIX . '::Bundle', $bundle );
}

sub require_bundle {
  my ($bundle) = @_;
  require Module::Runtime;
  return Module::Runtime::require_module( expand_bundle($bundle) );
}

sub create_bundle {
  my ( $bundle, @params ) = @_;
  require_bundle($bundle);
  return expand_bundle($bundle)->new(@params);
}

sub expand_policy {
  my ($policy) = @_;
  require Module::Runtime;
  return Module::Runtime::compose_module_name( 'Perl::Critic::Policy', $policy );
}

sub require_policy {
  my ($policy) = @_;
  require Module::Runtime;
  return Module::Runtime::require_module( expand_policy($policy) );

}

sub expand_action {
  my ($action) = @_;
  require Module::Runtime;
  return Module::Runtime::compose_module_name( $PREFIX . '::Action', $action );
}

sub require_action {
  my ($action) = @_;
  require Module::Runtime;
  return Module::Runtime::require_module( expand_action($action) );
}

sub create_action {
  my ( $action, @params ) = @_;
  require_action($action);
  return expand_action($action)->new(@params);
}

sub create_pseudoaction {
  my ( $action, @params ) = @_;
  return [ $action, ':definition_context', sniff_action_caller(1), @params ];
}

sub inflate_pseudoaction {
  my ($pseudo) = @_;
  return create_action( @{$pseudo} );
}

our $ACTION_WHITELIST = {};
{
  my $ACT_TREE = {
    "Role::Bundle" =>
      [ 'append_bundle', 'add_or_replace_plugin', 'add_or_replace_plugin_field', 'add_or_append_plugin_field', 'remove_plugin', ],
    "ActionList" => ['add_action'],
    "Util"       => ['create_pseudoaction'],
  };
  for my $key ( keys %$ACT_TREE ) {
    for my $v ( @{ $ACT_TREE->{$key} } ) {
      $ACTION_WHITELIST->{ $PREFIX . '::' . $key . '::' . $v } = 1;
    }
  }
}

sub sniff_action_caller {
  my ($start) = @_;
  my ( $callpkg, $callfile, $line, ) = caller($start);
  my ( undef, undef, undef, $sub, ) = caller( $start + 1 );
  while ( exists $ACTION_WHITELIST->{$sub} ) {
    $start++;
    ( $callpkg, $callfile, $line, ) = caller($start);
    ( undef, undef, undef, $sub, ) = caller( $start + 1 );

  }
  return {
    package => $callpkg,
    file    => $callfile,
    line    => $line,
    sub     => $sub
  };
}
1;

