cat /home/shlomif/Download/unpack/games/freecell/freecell-pro-3fc-deals/Int3.txt |
perl -lanE 'print if ( $_ > 5218337369 )' |
(
# lim=12000000
# lim=8500000
parallel -j4 --group --keep-order \
    bash ~/Download/unpack/games/freecell/freecell-3fc-determine-solvability/run-single.bash 2400000 "{}"
) | tee -a ~/Backup/Arcs/freecell-3fc-5e9-intractables.dump.txt
