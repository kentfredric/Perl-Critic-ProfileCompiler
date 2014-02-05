use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::add_or_replace_plugin;
$Perl::Critic::ProfileCompiler::Action::add_or_replace_plugin::VERSION = '0.001000';
# ABSTRACT: Forcibly make a new plugin appear with given configuration

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

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

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::Action::add_or_replace_plugin - Forcibly make a new plugin appear with given configuration

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
