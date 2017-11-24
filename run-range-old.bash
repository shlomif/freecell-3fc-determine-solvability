log_fn="$HOME/freecell-3fc-determine-solvability/vendu-10-3fc-output.txt"

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

export FREECELL_SOLVER_QUIET=1
ulimit -n 10000
unxz < ~/freecell-3fc-determine-solvability/vendu-10-3fc.txt.xz |
perl -lnE 'BEGIN { $s = int $ENV{START_FROM} ; } print if ( $_ > $s )' |
(
# lim=12000000
# lim=8500000
parallel -j2 --group --keep-order \
    bash ~/freecell-3fc-determine-solvability/run-single.bash 20000000 "{}"
) | tee -a "$log_fn"
touch ~/freecell-3fc-determine-solvability/COMPLETED_STAMP
echo 'Completed!' 1>&2
