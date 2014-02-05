use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Compatibility;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Compatibility
# Based on version 1.001

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Compatibility::ProhibitThreeArgumentOpen
  );
}

no Moo;

1;
