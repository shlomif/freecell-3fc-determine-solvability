Here is how to install, build and run fc-solve:

* Install some dependencies:

```
pacman -S cmake gcc git parallel perl perl-path-tiny
```

*

```
git clone https://github.com/shlomif/fc-solve.git
mkdir fc-solve/B
cd fc-solve/B
../source/Tatzer -l n2b --prefix="/home/shlomif/apps/fcs"  -l extra_speed --nowithout-max-num-states --disable-ni --nfc=3
make
```

