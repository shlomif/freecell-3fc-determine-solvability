s#(\n== ([0-9]+) ==\n\[\[== End ([0-9]+) ==\]\]\n)#
my ($t, $i, $i2) = ($1, $2, $3);
($i eq $i2) ? do {
STDERR->print("Handling $i\n");
"\n".`bash ~/Download/unpack/games/freecell/freecell-3fc-determine-solvability/run-single.bash 8000000 $i` ; } : $t
#egms;
