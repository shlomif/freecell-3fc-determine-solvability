# freecell-3fc-determine-solvability
Determine the solvability of 3-freecell deals in the Microsoft Freecell /
Freecell Pro range (see [this link](http://fc-solve.shlomifish.org/faq.html#what_are_ms_deals) for more information).

## Howto:

Here is how to install, build and run fc-solve:

* Install some dependencies:

```
pacman -S cmake gcc git gperftools parallel perl perl-path-tiny perl-template-toolkit
```

(or equivalent for other operating systems).

*

```
git clone https://github.com/shlomif/fc-solve.git
mkdir fc-solve/B
cd fc-solve/B
../source/Tatzer -l n2b --prefix="$HOME/apps/fcs"  -l extra_speed --nowithout-max-num-states --disable-ni --nfc=3
make
```

(Note that you need [Shlomif_Common](https://bitbucket.org/shlomif/shlomif-cmake-modules/overview) .)

* After that, select a range of deals from the file “Int3.txt” in
[this repository](https://bitbucket.org/theodorepringle/freecell-pro-3fc-deals/overview)
, put them in a file, tweak the "run-range.bash" script of this repository
and call it from the "fc-solve/B" directory where the fc-solve binaries were
built. The file "freecell-3fc-intractables.dump.txt" contains the already
processed results, so you should select those outside their range of deals. (Some
of them may still be intractable as marked with "Iterations count exceeded.").
