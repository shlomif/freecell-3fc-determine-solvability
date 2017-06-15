cat ~/freecell-3fc-determine-solvability/vendu-3fc.txt |
cat | # perl -lanE 'print if /\A29885917\z/ms..1' |
parallel -j4 --ungroup \
    bash ~/freecell-3fc-determine-solvability/run-single.bash 10000000 "{}" |
    tee -a ~/freecell-3fc-determine-solvability/vendu-3fc-output.txt

touch ~/freecell-3fc-determine-solvability/COMPLETED_STAMP
echo 'Completed!' 1>&2
