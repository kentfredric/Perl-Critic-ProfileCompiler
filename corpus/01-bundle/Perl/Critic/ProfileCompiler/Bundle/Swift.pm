use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler::Bundle::Swift;

# ABSTRACT: Profile Compiler Bundle for Perl-Critic-Swift
# Based on version 1.000003

# AUTHORITY

use Moo;

with 'Perl::Critic::ProfileCompiler::Role::Bundle::Simple';

sub policies {
  return qw(
    CodeLayout::RequireUseUTF8
    Documentation::RequirePODUseEncodingUTF8
  );
}

no Moo;

1;
