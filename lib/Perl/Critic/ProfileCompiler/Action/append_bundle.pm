use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::append_bundle;
$Perl::Critic::ProfileCompiler::Action::append_bundle::VERSION = '0.001000';
# ABSTRACT: Inject a bundle of configuration into a parent configuration

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moo;
use Perl::Critic::ProfileCompiler::Util qw( create_bundle );
with 'Perl::Critic::ProfileCompiler::Role::Action';

has 'bundle' => (
  is       => ro =>,
  required => 1,
);

has 'parameters' => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    return {};
  },
);

sub inline {
  my ( $self, $stack ) = @_;
  my $bundle = create_bundle( $self->bundle, %{ $self->parameters } );
  $bundle->configure;
  my $infl = $bundle->actionlist->get_inflated;
  push @{$stack}, @{ $infl->actions };
  return $stack;
}
no Moo;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::Action::append_bundle - Inject a bundle of configuration into a parent configuration

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
