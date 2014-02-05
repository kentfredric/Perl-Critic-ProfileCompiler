use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Itch;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Itch
# Based on version 0.07

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    CodeLayout::ProhibitHashBarewords
  );
}

no Moo;

1;
