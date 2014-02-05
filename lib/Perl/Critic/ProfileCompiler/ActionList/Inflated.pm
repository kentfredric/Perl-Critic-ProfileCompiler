use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::ActionList::Inflated;
$Perl::Critic::ProfileCompiler::ActionList::Inflated::VERSION = '0.001000';
# ABSTRACT: An inflated ActionList container

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moo;

has actions => ( is => ro =>, required => 1 );

#has parent  => ( is => ro =>, required => 1 );

sub can_inline {
  my ($self) = @_;
  for my $action ( @{ $self->actions } ) {
    return 1 if $action->can('inline');
  }
  return;
}

sub inline {
  my ($self) = @_;
  my @stack;
  for my $action ( @{ $self->actions } ) {
    @stack = @{ $action->_inline( \@stack ) };
  }
  return Perl::Critic::ProfileCompiler::ActionList::Inflated->new(
    actions => \@stack,
    parent  => $self,
  );
}

sub recursive_inline {
  my ($self) = @_;
  my $next = $self;
  while ( $next->can_inline ) {
    $next = $next->inline;
  }
  return $next;
}

no Moo;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::ActionList::Inflated - An inflated ActionList container

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
