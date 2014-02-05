use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Moose;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Moose
# Based on version 0.999_002

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Moose::ProhibitMultipleWiths
    Moose::ProhibitNewMethod
    Moose::RequireCleanNamespace
    Moose::RequireMakeImmutable
  );
}

no Moo;

1;
