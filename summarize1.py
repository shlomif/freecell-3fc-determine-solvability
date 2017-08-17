import re

def line_iter():
    # 'vendu-3fc-output.txt'
    FILENAMES = ['freecell-3fc-amazon.txt', 'vendu-6-3fc-output.txt', 'vendu-2-3fc-output.txt', 'vendu-3-3fc-output.txt', 'vendu-4-3fc-output.txt', 'vendu-5-3fc-output.txt', ]
    for fn in FILENAMES:
        with open(fn, 'r') as fh:
            for l in fh:
                yield l.rstrip('\r\n')

def deal_iter():
    it = line_iter()
    l = it.next()
    prev_idx = -1
    while l:
        lines = [l]
        l = it.next()
        while l is not None and not l.startswith('[[== End '):
            lines.append(l)
            l = it.next()
        lines.append(l)
        idx1 = int(re.match(r'^== ([0-9]+) ==$', lines[0]).group(1))
        idx2 = int(re.match(r'^\[\[== End ([0-9]+) ==\]\]$', lines[-1]).group(1))
        if idx1 != idx2:
            raise BaseException("index mismatch - %d ; %d" % (idx1,idx2))
        verdict = None
        count = -1
        if len([x for x in lines if x.startswith("I could not solve this game.")]) > 0:
            verdict = "impossible"
        elif len([x for x in lines if x.startswith("This game is solv")]) > 0:
            verdict = "solved"
        elif len([x for x in lines if x.startswith("Iterations count exceeded")]) > 0:
            verdict = "intract"
            for x in lines:
                m = re.match(r'^Total number of states checked is ([0-9]+)\.', x)
                if m:
                    count = int(m.group(1))
                    break
        else:
            print(lines)
            raise BaseException("Invalid state - %d" % (idx1))
            # print("Invalid state - %d" % (idx1))
        if not idx1 > prev_idx:
            raise BaseException("Wrong indexes order %d -> %d" % (prev_idx, idx1))
        prev_idx = idx1
        yield {'idx': idx1, 'verdict': verdict, 'count': count}
        l = it.next()

cnt = 0
for d in deal_iter():
    cnt += 1
    # print(d)

print("Deals Count = %d" % (cnt))
