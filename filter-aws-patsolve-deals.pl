#!/usr/bin/perl

use strict;
use warnings;

use IO::All qw/ io /;
use Path::Tiny qw/ path /;

my %solved = map { $_ => 1 } map { /\A#([0-9]+) - Won\z/ ? $1 : die} grep /- Won/,
io->file("$ENV{HOME}/Download/unpack/games/freecell/freecell-3fc-determine-solvability/aws-patsolve/run-dump-4.txt")->chomp->getlines;


path("Int3.txt")->edit_lines_utf8(sub { $_ = '' if /([0-9]+)/ and exists$solved{$1}});
