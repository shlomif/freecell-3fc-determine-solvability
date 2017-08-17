#!/usr/bin/perl

use strict;
use warnings;

my @q;
my @result;
my $idx;

sub my_print
{
    print map { "$_\n" } "== $idx ==", @q, "[[== End $idx ==]]";
    $#q = -1;
}
while ( my $l = <> )
{
    chomp $l;
    if (my ($new_idx) = $l =~ /\A\#([0-9]+)\z/)
    {
        if (defined$idx)
        {
            my_print;
        }
        $idx = $new_idx;
    }
    else
    {
        push @q, $l;
    }
}
my_print;
