import sys

for l in sys.stdin:
    i = int(l.rstrip('\r\n'))
    print("%d\t%d" % (i // 10000000, i))
