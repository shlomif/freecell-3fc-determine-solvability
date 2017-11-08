cat ~/s | (while read i; do echo $i ; bash run-single.bash 20000000 "$i" | tee ~/RES/1/"$i"/stdout ; done)
