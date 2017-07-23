unxz < ~/freecell-3fc-determine-solvability/vendu-4-3fc.txt.xz |
perl -lnE 'print if $_ > 4822584186 ' |
parallel -j2 --group --keep-order \
    bash ~/freecell-3fc-determine-solvability/run-single.bash 20000000 "{}" |
    tee -a ~/freecell-3fc-determine-solvability/vendu-4-3fc-output.txt

touch ~/freecell-3fc-determine-solvability/COMPLETED_STAMP
echo 'Completed!' 1>&2
