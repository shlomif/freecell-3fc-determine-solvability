log_fn="$HOME/Backup/Arcs/freecell-3fc-7e9-intractables.dump.txt"
if test -e "$log_fn"
then
    export START_FROM="$(tail -1 "$log_fn" | perl -lnE 'print $1 if /\A\[\[== End ([0-9]+) ==/')"
else
    export START_FROM="-1"
fi
if test -z "$START_FROM"
then
    echo "Error" 1>&2
    exit -1
fi
cat /home/shlomif/Download/unpack/games/freecell/freecell-pro-3fc-deals/Int3.txt |
perl -lnE 'BEGIN { $s = int $ENV{START_FROM} ; } print if ( $_ > $s )' |
(
# lim=12000000
# lim=8500000
parallel -j4 --group --keep-order \
    bash ~/Download/unpack/games/freecell/freecell-3fc-determine-solvability/run-single.bash 2400000 "{}"
) | tee -a "$log_fn"
