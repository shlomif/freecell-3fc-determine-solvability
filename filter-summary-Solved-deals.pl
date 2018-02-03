#!/usr/bin/perl

use strict;
use warnings;

use IO::All qw/ io /;
use Path::Tiny qw/ path /;

my $REPO_PATH =
"$ENV{HOME}/Download/unpack/games/freecell/freecell-3fc-determine-solvability";
my %solved = map { $_ => 1 } map { /\A([0-9]+) =/ ? $1 : die } grep /Solved/,
    map {
    io->file("$REPO_PATH/l-cm-going-over-the-intractables/$_")->chomp->getlines
    } (
    qw#
        fc3-int3-results.txt
        fc3-int3-results--2.txt
        fc3-int3-results--3.txt
        fc3-int3-results--4.txt
        vendu-20-3fc-output.txt
        #
    );

foreach my $l (
    io->file(
"$REPO_PATH/try-to-find-random-dfs-seeds-that-solve-ranges-of-deals/3e9-to-4e9/seeds.log.txt"
    )->chomp->getlines
    )
{
    if ( my ($deal) = $l =~ /\AFound seed = [0-9]+ for deal = ([0-9]+)\z/ )
    {
        $solved{$deal} = 1;
    }
    else
    {
        die "wrong line '$l'!";
    }
}

path("Int3.txt")
    ->edit_lines_utf8( sub { $_ = '' if /([0-9]+)/ and exists $solved{$1} } );
