#!/bin/bash
lim="$1"
shift
n="$1"
shift
echo "== $n =="
./board_gen/pi-make-microsoft-freecell-board -t "$n" | \
    ./fc-solve -to 01ABCDEF -sp r:tf -sam -sel -p -t -mi "$lim"
echo "[[== End $n ==]]"
