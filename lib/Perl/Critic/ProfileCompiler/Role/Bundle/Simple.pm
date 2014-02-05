use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Role::Bundle::Simple;
$Perl::Critic::ProfileCompiler::Role::Bundle::Simple::VERSION = '0.001000';
# ABSTRACT: A role for bundles that are just collections to policies with no advanced mechanics

use Moo::Role;

with 'Perl::Critic::ProfileCompiler::Role::Bundle';

requires 'policies';

sub configure {
  my ($self) = @_;
  for my $policy ( $self->policies ) {
    $self->add_or_replace_plugin($policy);
  }
}

no Moo::Role;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::Role::Bundle::Simple - A role for bundles that are just collections to policies with no advanced mechanics

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
