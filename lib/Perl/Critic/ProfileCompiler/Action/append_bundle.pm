use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Action::append_bundle;

# ABSTRACT: Inject a bundle of configuration into a parent configuration

# AUTHORITY

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
  my $infl   = $bundle->actionlist->get_inflated;
  my $xstack = [ @{$stack} ];
  push @{$xstack}, @{ $infl->actions };
  return $xstack;
}
no Moo;

1;

