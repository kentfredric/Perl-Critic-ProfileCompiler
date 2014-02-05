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
    qw( add_action_definition_context action_definition_context_list action_definition_context ),
  ],
};

sub expand_bundle {
  my ($bundle) = @_;
  require Module::Runtime;
  return Module::Runtime::compose_module_name( 'Perl::Critic::ProfileCompiler::Bundle', $bundle );
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
  return Module::Runtime::compose_module_name( 'Perl::Critic::ProfileCompiler::Action', $action );
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
  return [ $action, @params ];
}

sub inflate_pseudoaction {
  my ($pseudo) = @_;
  return create_action( @{$pseudo} );
}

{
  my $DC_KEY = ':definition_context';

  sub action_definition_context {
    my ($d)      = @_;
    my (@caller) = caller($d);
    return {
      package  => $caller[0],
      filename => $caller[1],
      line     => $caller[2],
    };
  }

  sub action_definition_context_list {
    my ($d) = @_;
    return ( $DC_KEY => action_definition_context( $d + 1 ) );
  }

  sub add_action_definition_context {
    my ( $hash, $d ) = @_;
    return $hash if exists $hash->{$DC_KEY};
    $hash->{$DC_KEY} = action_definition_context( $d + 1 );
    return $hash;
  }
}
1;

