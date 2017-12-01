#!/usr/bin/perl

use strict;
use warnings;

use IO::All qw/ io /;
use Path::Tiny qw/ path /;

my %solved = map { $_ => 1 } map { /\A([0-9]+) =/ ? $1 : die} grep /Solved/,
map { io->file("$ENV{HOME}/Download/unpack/games/freecell/freecell-3fc-determine-solvability/l-cm-going-over-the-intractables/$_")->chomp->getlines } (qw# fc3-int3-results.txt vendu-20-3fc-output.txt #);

path("Int3.txt")->edit_lines_utf8(sub { $_ = '' if /([0-9]+)/ and exists$solved{$1}});
