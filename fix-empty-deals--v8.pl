use strict;
use warnings;

use Path::Tiny qw/ path /;

my $ITERS_LIM = $ENV{LIM} || 20000000;
$ITERS_LIM =~ s#[^0-9]##g;

my $EXE_PATH = $ENV{EXE} || "bash $ENV{HOME}/Download/unpack/games/freecell/freecell-3fc-determine-solvability/run-single.bash";
foreach my $fn (@ARGV)
{
    path($fn)->edit_utf8(sub {
            1 while
s#(\n== ([0-9]+) ==\n\[\[== End ([0-9]+) ==\]\]\n)#
my ($t, $i, $i2) = ($1, $2, $3);
($i eq $i2) ? do {
STDERR->print("Handling $i\n");
"\n".`$EXE_PATH "$ITERS_LIM" $i` } : $t
#egms;
    });
}
