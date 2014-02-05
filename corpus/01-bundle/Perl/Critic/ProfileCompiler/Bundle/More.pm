use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::More;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-More
# Based on version 1.003

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    CodeLayout::RequireASCII
    Editor::RequireEmacsFileVariables
    ErrorHandling::RequireUseOfExceptions
    Modules::PerlMinimumVersion
    Modules::RequirePerlVersion
    ValuesAndExpressions::RequireConstantOnLeftSideOfEquality
    ValuesAndExpressions::RestrictLongStrings
  );
}

no Moo;

1;
