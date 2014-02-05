use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::ActionList::Inflated;

# ABSTRACT: An inflated ActionList container

# AUTHORITY

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

