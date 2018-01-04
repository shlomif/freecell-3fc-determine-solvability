cd ~/Backup/Arcs/fc-solve/3fc-b/
log_fn="/home/shlomif/Arcs/fc3-int3-results--3.txt"

if test -e "$log_fn"
then
    export START_FROM="$(tail -1 "$log_fn" | perl -lnE 'print $1 if /\A([0-9]+) =/')"
else
    export START_FROM="2000000000"
fi

if test -z "$START_FROM"
then
    echo "Error" 1>&2
    exit -1
fi

export FREECELL_SOLVER_QUIET=1
./summary-fc-solve slurp <(perl -lnE 'BEGIN { $s = int $ENV{START_FROM} ; } print if ( $_ > $s and $_ < 3e9 )' < ~/Download/unpack/games/freecell/freecell-pro-3fc-deals--split/Int3.txt ) -- -l cm -mi 20000000 |
    tee -a "$log_fn" |
    commify |
    timestamper

n -m 3fc