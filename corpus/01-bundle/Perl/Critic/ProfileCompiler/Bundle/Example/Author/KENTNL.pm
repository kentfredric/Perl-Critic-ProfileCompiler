use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Example::Author::KENTNL;

# ABSTRACT: Example bundle for testing

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle';

sub configure {
  my ($self) = @_;
  $self->append_bundle('Core');
  $self->append_bundle('Itch');
  $self->add_or_replace_plugin('Variables::ProhibitUnusedVarsStricter');
  $self->append_bundle('Pulp');
  $self->append_bundle('More');
  $self->append_bundle('Tics');
  $self->append_bundle('StricterSubs');
  $self->append_bundle('Deprecated');
  $self->append_bundle('Lax');
  $self->append_bundle('Moose');
  $self->append_bundle('Compatibility');
  $self->append_bundle('Swift');
  $self->append_bundle('Bangs');

  # NOTE: "Note" is ok in a comment. Kthx
  $self->remove_plugin('Bangs::ProhibitFlagComments');

  # Sooo annoying. And ugly.
  $self->remove_plugin('CodeLayout::ProhibitHashBarewords');

  # Death to ASCII. Long live UTF8
  $self->remove_plugin('CodeLayout::RequireASCII');

  # Barfs because dzil munges post-tidy
  $self->remove_plugin('CodeLayout::RequireTidyCode');

  # Requiring new versions of Perl just for POD is silly
  $self->remove_plugin('Compatibility::PodMinimumVersion');

  # Prohibitng 'if' on the right just makes code messier with indentation.
  $self->remove_plugin('ControlStructures::ProhibitPostfixControls');

  # Good, but currently bugged because it prefers only one case of `utf8`
  # Will be re-added when that is fixed.
  $self->remove_plugin('Documentation::RequirePODUseEncodingUTF8');

  # Horrible, because its not really a good thing to have sections with
  # nothing in them that you're not using.
  $self->remove_plugin('Documentation::RequirePodSections');

  # Yeech. This is in ::Deprecated for a reason.
  $self->remove_plugin('Editor::RequireEmacsFileVariables');

  # Problem if the policies are not installed where testing :(
  $self->remove_plugin('Miscellanea::ProhibitUselessNoCritic');

  # No good, because just makes bogus commit churn with git
  $self->remove_plugin('Miscellanea::RequireRcsKeywords');

  # ???
  $self->remove_plugin('Modules::RequireExplicitInclusion');

  # Fails on __PACKAGE__, reintroduce when fixed.
  $self->remove_plugin('Modules::RequireExplicitPackage');

  # Diamond inheritance is over 9000 peskys
  $self->remove_plugin('Moose::ProhibitMultipleWiths');

  #  =>, is a handy way to quote the lhs, while stil indicating
  #  the end of a pair,  ie:
  #  has foo => (
  #       is => ro =>,
  #       required => 1 =>,
  #  )
  $self->remove_plugin('ValuesAndExpressions::ProhibitEmptyCommas');

  # Magic numbers are bad, but this messes up so much its just annoying
  $self->remove_plugin('ValuesAndExpressions::ProhibitMagicNumbers');

  # !?!?$$ and friends are helpful, English is awful
  $self->remove_plugin('Variables::ProhibitPunctuationVars');

}

no Moo;
1;

