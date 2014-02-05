use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Pulp;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Pulp
# Based on version 80

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    CodeLayout::ProhibitFatCommaNewline
    CodeLayout::ProhibitIfIfSameLine
    CodeLayout::RequireFinalSemicolon
    CodeLayout::RequireTrailingCommaAtNewline
    Compatibility::ConstantLeadingUnderscore
    Compatibility::ConstantPragmaHash
    Compatibility::Gtk2Constants
    Compatibility::PerlMinimumVersionAndWhy
    Compatibility::PodMinimumVersion
    Compatibility::ProhibitUnixDevNull
    Documentation::ProhibitAdjacentLinks
    Documentation::ProhibitAdjacentLinks::Parser
    Documentation::ProhibitBadAproposMarkup
    Documentation::ProhibitDuplicateHeadings
    Documentation::ProhibitDuplicateSeeAlso
    Documentation::ProhibitLinkToSelf
    Documentation::ProhibitParagraphEndComma
    Documentation::ProhibitParagraphTwoDots
    Documentation::ProhibitUnbalancedParens
    Documentation::ProhibitVerbatimMarkup
    Documentation::RequireEndBeforeLastPod
    Documentation::RequireFinalCut
    Documentation::RequireLinkedURLs
    Miscellanea::TextDomainPlaceholders
    Miscellanea::TextDomainUnused
    Modules::ProhibitModuleShebang
    Modules::ProhibitPOSIXimport
    Modules::ProhibitUseQuotedVersion
    ValuesAndExpressions::ConstantBeforeLt
    ValuesAndExpressions::NotWithCompare
    ValuesAndExpressions::ProhibitArrayAssignAref
    ValuesAndExpressions::ProhibitBarewordDoubleColon
    ValuesAndExpressions::ProhibitDuplicateHashKeys
    ValuesAndExpressions::ProhibitEmptyCommas
    ValuesAndExpressions::ProhibitFiletest_f
    ValuesAndExpressions::ProhibitNullStatements
    ValuesAndExpressions::ProhibitUnknownBackslash
    ValuesAndExpressions::RequireNumericVersion
    ValuesAndExpressions::UnexpandedSpecialLiteral
  );
}

no Moo;

1;
