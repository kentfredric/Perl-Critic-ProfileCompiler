use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Util;
$Perl::Critic::ProfileCompiler::Util::VERSION = '0.001000';
# ABSTRACT: Misc Utility functions

# AUTHORTY

use Sub::Exporter::Progressive -setup => {
  exports => [
    qw( expand_bundle require_bundle create_bundle ),
    qw( require_policy expand_policy ),
    qw( expand_action require_action create_action )
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

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::Util - Misc Utility functions

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
