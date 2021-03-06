use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Perl::Critic::ProfileCompiler;

# ABSTRACT: Generate canonical perlcritic.rc files from reduced configuration

# AUTHORITY

use Moo;

=head1 DESCRIPTION

L<< C<Perl::Critic>|Perl::Critic >> default behavior is to simply assume if you want a given policy, that you would have
installed it already, and that if that policy is installed, then it assumes you want it.

L<< C<Perl::Critic>|Perl::Critic >> also currently has a limitation, that if you want to exclude several policies, that can be
messy.

There are ways around both these issues, but they're rather messy.

There's no clear way to say:

    - I want everything provided by Perl::Critic::Pulp
    - Except this policy here and this here
    - I also want everything provided by Perl::Critic::Swift
    - Except this policy here and this here

This module exists to work around this problem by allowing you to define short-hand configuration files, that can consume bundles
of policies, which can be expanded and augmented into a strict and comprehensive canonical Perl::Critic C<perlcritic.rc> file,
comparable to C<perlcritic --profile-proto>'s output, but adjusted to explicitly communicate your requirements.

This module also aims to make it easier for C<CPAN> authors to share and distribute Perl::Critic profile configurations via
C<CPAN>, so that such profiles can be shared between distributions with minor adjustments instead of each and every distribution
needing to hand-copy and augment the C<perlcritic.rc> file.

=head1 BUNDLES

It is intended that C<CPAN> authors who use this toolkit make bundles in one of the following forms.

The rationale behind the naming schemes are articulated in my
L<< C<Dist::Zilla> Author Bundle|Dist::Zilla::PluginBundle::Author::KENTNL/NAMING-SCHEME >>

=head2 Perl::Critic Distribution Centered Bundles

These are intended to mimic other C<CPAN> distribution names.

For instance, a bundle that provides all the contents of L<< C<Perl::Critic::Pulp>|Perl::Critic::Pulp >> would be included in a
bundle:

    Perl::Critic::ProfileCompiler::Bundle::Pulp

And added via:

    [@Pulp]

=head2 Perl::Critic Thematic Bundles

These are intended as logical replacements for C<Perl::Critic> Policy themes.

    Perl::Critic::ProfileCompiler::Bundle::Theme::core

This would be a logical substitute for the policy theme

    core

And added via:

    [@Theme::core]

=head2 Organizational Authority Centered Bundles

These are intended for organizations, such as workplaces and non-profit organizations, such as P5P itself.

The goal being that those organizations can provide recommended standard critic policy sets independent of Perl::Critic's release
cycle.

For instance, P5P could provide and regulate their own bundle as follows:

    Perl::Critic::ProfileCompiler::Bundle::Org::P5P

Mozilla could do this:

    Perl::Critic::ProfileCompiler::Bundle::Org::Mozilla

Enlightened Perl Organization could do this:

    Perl::Critic::ProfileCompiler::Bundle::Org::EPO

And they'd be included as:

    [@Org::P5P]
    [@Org::Mozilla]
    [@Org::EPO]

Respectively.

=head2 Author Authority Centered Bundles

These are intended for individual C<CPAN> authors who just have a way of doing things that they want to use in several places.

I for instance, will eventually be creating:

    Perl::Critic::ProfileCompiler::Bundle::Author::KENTNL

Which will be available as

    [@Author::KENTNL]

=cut

=head1 CONFIGURATION AND EXECUTION

To utilize the profile compiler, a first step is creating a C<perlcritic-meta.rc> file.

This contains the specification for the canonical configuration you wish to use.

A tool will eventually arise to read and process this file, and emit a C<perlcritic.rc> file that represents the canonical
configuration specified.

    perlcritic-pc ./perlcritic-meta.rc -o perlcritic.rc

I shall endeavor to also eventually have a L<< C<Dist::Zilla>|Dist::Zilla >> plugin that translates one into the other during
C<build> phase, for authors who wish to truly keep their source tree free of the canonicalized form.

=cut

no Moo;

1;
