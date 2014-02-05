use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Tics;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Tics
# Based on version 0.008

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    Tics::ProhibitLongLines
    Tics::ProhibitManyArrows
    Tics::ProhibitUseBase
  );
}

no Moo;

1;
