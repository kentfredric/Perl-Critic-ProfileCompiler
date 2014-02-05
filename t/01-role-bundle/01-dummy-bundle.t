use strict;
use warnings;

use Test::More;
use Test::Fatal qw( exception );
use Path::Tiny qw( path );
use Perl::Critic::ProfileCompiler::Util qw( require_bundle expand_bundle create_bundle );

use lib 'corpus/01-bundle/';

my @bundles;

{

  my $froot = path('corpus/01-bundle/Perl/Critic/ProfileCompiler/Bundle');
  my $files = $froot->iterator(
    {
      recurse => 1,
    }
  );
  while ( my $file = $files->() ) {
    next if -d $file;
    next unless $file->basename =~ /\.pm$/;
    my $rname = $file->relative($froot)->stringify;
    $rname =~ s/\.pm$//;
    $rname =~ s{/}{::}g;
    push @bundles, $rname;
  }
}

for my $bn ( sort { rand() <=> rand() } @bundles ) {

  subtest "$bn" => sub {
    my ( $err, $bundle );

    $err = exception {
      $bundle = create_bundle($bn);
    };
    if ( not is( $err, undef, 'expand/require/create does not fail' ) ) {
      diag explain $err;
      return;
    }

    return unless can_ok( $bundle, qw(DOES) );
    return unless ok( $bundle->DOES('Perl::Critic::ProfileCompiler::Role::Bundle'), '->DOES(::Bundle)' );
    return unless can_ok( $bundle, qw( configure ) );

    $err = exception {
      $bundle->configure;
    };
    is( $err, undef, 'Configure does not fail' ) or diag explain $err;

    return unless can_ok( $bundle, qw(actionlist) );
    my $actionlist = $bundle->actionlist;
    return unless can_ok( $actionlist, 'action_dependencies' );
    my (@deps) = $actionlist->action_dependencies;

    #note explain \@deps;
    return unless can_ok( $actionlist, 'load_action_dependencies' );
    $actionlist->load_action_dependencies;
    return unless can_ok( $actionlist, 'get_inflated' );
    my $inf = $actionlist->get_inflated;

    #note explain $inf;
    note "Actions: " . scalar @{ $inf->recursive_inline->actions };
  };
}
done_testing;
