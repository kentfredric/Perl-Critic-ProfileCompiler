use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::ActionList;
$Perl::Critic::ProfileCompiler::ActionList::VERSION = '0.001000';
# ABSTRACT: A list of actions

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moo;
use Try::Tiny qw( try catch );
use Perl::Critic::ProfileCompiler::Util
  qw( create_pseudoaction sniff_action_caller require_action expand_action inflate_pseudoaction );

has literal_actions => (
  is      => ro =>,
  lazy    => 1,
  builder => sub {
    return [];
  },
);

sub get_inflated {
  my ($self) = @_;
  $self->load_action_dependencies();
  require Perl::Critic::ProfileCompiler::ActionList::Inflated;
  return Perl::Critic::ProfileCompiler::ActionList::Inflated->new(
    actions => [ map { inflate_pseudoaction($_) } @{ $self->literal_actions } ],
    parent  => $self,
  );
}

sub add_action {
  my ( $self, $action_name, %action_params ) = @_;
  push @{ $self->literal_actions }, create_pseudoaction( $action_name, %action_params );
}

sub action_dependencies {
  my ($self) = @_;
  my %used;
  for my $action ( @{ $self->literal_actions } ) {
    $used{ $action->[0] } = 1;
  }
  return keys %used;
}

sub load_action_dependencies {
  my ($self) = @_;
  my %status;
  my @errors;

  for my $action ( $self->action_dependencies ) {
    my $aname = expand_action($action);
    try {
      require_action($action);
      $status{$action} = 1;
    }
    catch {
      $status{$action} = 0;

      push @errors,
        {
        action => $action,
        module => $aname,
        error  => $_,
        };
    }
  }
  if (@errors) {
    my $message = qq[];

    $message .= sprintf "Failed to load %s required actions, are they installed?:\n", scalar @errors;
    for my $error (@errors) {
      $message .= sprintf " %s ( %s )\n", $error->{action}, $error->{module};
    }
    $message .= "\n";

    for (@errors) {
      $message .= $_->{error};
      $message .= "\n";
    }
    warn $message;
    die \@errors;
  }
}

no Moo;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Perl::Critic::ProfileCompiler::ActionList - A list of actions

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
