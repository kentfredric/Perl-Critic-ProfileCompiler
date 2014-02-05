use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::remove_plugin;
$Perl::Critic::ProfileCompiler::Action::remove_plugin::VERSION = '0.001000';
# ABSTRACT: Remove a plugin that is already added

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'plugin' => (
  is       => ro =>,
  required => 1,
);

no Moo;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::Action::remove_plugin - Remove a plugin that is already added

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
