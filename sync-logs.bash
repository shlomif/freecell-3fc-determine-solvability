#!/bin/bash
cp -f ~/Backup/Arcs/freecell-3fc-intractables.dump.txt .
< ~/Backup/Arcs/fc-solve/from-amazon-aws--5/downloaded/freecell-3fc-amazon.txt \
    perl -lapE 's#\A[0-9]+\.[0-9]*\t## or die "wrong format"' > \
    freecell-3fc-amazon.txt
git add -u .
