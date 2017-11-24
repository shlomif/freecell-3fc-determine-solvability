log_fn="$HOME/freecell-3fc-determine-solvability/vendu-20-3fc-output.txt"

if test -e "$log_fn"
then
    export START_FROM="$(tail -1 "$log_fn" | perl -lnE 'print $1 if /\A([0-9]+) =/')"
else
    export START_FROM="1000000000"
fi

if test -z "$START_FROM"
then
    echo "Error" 1>&2
    exit -1
fi

export FREECELL_SOLVER_QUIET=1
./summary-fc-solve slurp <(perl -lnE 'BEGIN { $s = int $ENV{START_FROM} ; } print if ( $_ > $s )' < ~/freecell-3fc-determine-solvability/Int3.txt ) -- -l cm -mi 40000000 | \
tee -a "$log_fn"
touch ~/freecell-3fc-determine-solvability/COMPLETED_STAMP
echo 'Completed!' 1>&2
