import re

count_re = re.compile(r'^Total number of states checked is ([0-9]+)\.')
start_re = re.compile(r'^== ([0-9]+) ==$')
end_re = re.compile(r'^\[\[== End ([0-9]+) ==\]\]$')


class DealResult(object):
    """a deal result"""

    IMP = 0
    SOLVED = 1
    INTRACT = 2

    def __init__(self, idx, lines):
        self.idx = idx
        self.count = -1
        for x in lines:
            if x.startswith("I could not"):
                self.verdict = self.IMP
                break
            elif x.startswith("This game is solv"):
                self.verdict = self.SOLVED
                break
            elif x.startswith("Iterations count exceeded"):
                self.verdict = self.INTRACT
                for y in lines:
                    m = count_re.match(y)
                    if m:
                        self.count = int(m.group(1))
                        break
                break
        else:
            print(lines)
            raise BaseException("Invalid state - %d" % (idx))


def line_iter():
    # 'vendu-3fc-output.txt'
    FILENAMES = [
           'vendu-7-3fc-output.txt',
           'freecell-3fc-amazon.txt',
           'vendu-8-3fc-output.txt',
           'vendu-6-3fc-output.txt',
           'vendu-9-3fc-output.txt',
           'vendu-2-3fc-output.txt',
           'vendu-3-3fc-output.txt',
           'vendu-4-3fc-output.txt',
           'vendu-5-3fc-output.txt',
           ]
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
        idx1 = int(start_re.match(lines[0]).group(1))
        idx2 = int(end_re.match(lines[-1]).group(1))
        if idx1 != idx2:
            raise BaseException("index mismatch - %d ; %d" % (idx1, idx2))
        result = DealResult(idx1, lines)
        if not idx1 > prev_idx:
            raise BaseException("Wrong indexes order %d -> %d" %
                                (prev_idx, idx1))
        prev_idx = idx1
        yield result
        l = it.next()

cnt = 0
for d in deal_iter():
    cnt += 1
    # print(d)

print("Deals Count = %d" % (cnt))
