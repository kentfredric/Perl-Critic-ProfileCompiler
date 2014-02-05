use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::StricterSubs;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-StricterSubs
# Based on version 0.03

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Modules::RequireExplicitInclusion
    Subroutines::ProhibitCallsToUndeclaredSubs
    Subroutines::ProhibitCallsToUnexportedSubs
    Subroutines::ProhibitExportingUndeclaredSubs
    Subroutines::ProhibitQualifiedSubDeclarations
  );
}

no Moo;

1;
