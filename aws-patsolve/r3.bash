export FREECELL_SOLVER_QUIET=1
cat ~/Int3.txt | perl -lnE 'say if $_ > 1000000000' | \
(while read i; do 
echo "== $i =="
export PATSOLVE_START="$i" PATSOLVE_END="$((i + 1))"
	./patsolve -f -t3 -S | \
	tee ~/"deal-$i-cm.dump.txt"		
echo "[[== $i ==]]"
	done
) 2>&1 | tee ~/run-dump-4.txt
