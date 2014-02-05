use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Lax;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Lax
# Based on version 0.010

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Lax::ProhibitComplexMappings::LinesNotStatements
    Lax::ProhibitEmptyQuotes::ExceptAsFallback
    Lax::ProhibitLeadingZeros::ExceptChmod
    Lax::ProhibitStringyEval::ExceptForRequire
    Lax::RequireEndWithTrueConst
    Lax::RequireExplicitPackage::ExceptForPragmata
  );
}

no Moo;

1;
