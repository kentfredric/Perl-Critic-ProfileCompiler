use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Bangs;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Bangs
# Based on version 1.10

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Bangs::ProhibitBitwiseOperators
    Bangs::ProhibitCommentedOutCode
    Bangs::ProhibitDebuggingModules
    Bangs::ProhibitFlagComments
    Bangs::ProhibitNoPlan
    Bangs::ProhibitNumberedNames
    Bangs::ProhibitRefProtoOrProto
    Bangs::ProhibitUselessRegexModifiers
    Bangs::ProhibitVagueNames
  );
}

no Moo;

1;
