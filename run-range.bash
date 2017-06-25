unxz < ~/freecell-3fc-determine-solvability/vendu-2-3fc.txt.xz |
cat | # perl -lanE 'print if /\A29885917\z/ms..1' |
parallel -j2 --group --keep-order \
    bash ~/freecell-3fc-determine-solvability/run-single.bash 20000000 "{}" |
    tee -a ~/freecell-3fc-determine-solvability/vendu-2-3fc-output.txt

touch ~/freecell-3fc-determine-solvability/COMPLETED_STAMP
echo 'Completed!' 1>&2
