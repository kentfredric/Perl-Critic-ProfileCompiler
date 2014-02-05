use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Deprecated;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Deprecated
# Based on version 1.119

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Miscellanea::RequireRcsKeywords
    NamingConventions::ProhibitMixedCaseSubs
    NamingConventions::ProhibitMixedCaseVars
  );
}

no Moo;

1;
