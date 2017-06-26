cat freecell-3fc-intractables.dump.txt |
    perl -lpE 'if (/\A== ([0-9]+) ==\z/){$y=$1;print "[[== End $x ==]]"if defined $x;$x=$y;}' |
    uniq > new.txt
