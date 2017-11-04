import re
import sys

COUNT_RE = re.compile(r'^Total number of states checked is ([0-9]+)\.')
START_RE = re.compile(r'^== ([0-9]+) ==$')
END_RE = re.compile(r'^\[\[== End ([0-9]+) ==\]\]$')


class DealResult(object):
    """a deal result"""

    IMP = 0
    SOLVED = 1
    INTRACT = 2

    def __init__(self, idx, lines):
        self.idx = idx
        self.count = -1
        for line in lines:
            if line.startswith("I could not"):
                self.verdict = self.IMP
                break
            elif line.startswith("This game is solv"):
                self.verdict = self.SOLVED
                break
            elif line.startswith("Iterations count exceeded"):
                self.verdict = self.INTRACT
                for line_w_count in lines:
                    m = COUNT_RE.match(line_w_count)
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
           'vendu-10-3fc-output.txt',
           'aws-3-3fc-output.txt',
           'aws-2-3fc-output.txt',
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
        idx1 = int(START_RE.match(lines[0]).group(1))
        idx2 = int(END_RE.match(lines[-1]).group(1))
        if idx1 != idx2:
            raise BaseException("index mismatch - %d ; %d" % (idx1, idx2))
        result = DealResult(idx1, lines)
        if not idx1 > prev_idx:
            raise BaseException("Wrong indexes order %d -> %d" %
                                (prev_idx, idx1))
        prev_idx = idx1
        yield result
        l = it.next()


def main(argv):
    cnt = 0
    verdict_names = {DealResult.IMP: "IMP", DealResult.SOLVED: "SOLVED",
                     DealResult.INTRACT: "INTRACT"}
    verdict_counts = {}
    for verdict in verdict_names.keys():
        verdict_counts[verdict] = 0
    with open('intract1.txt', 'w') as fh:
        for d in deal_iter():
            if d.verdict == d.INTRACT:
                fh.write("%d\n" % (d.idx))
            verdict_counts[d.verdict] += 1
            cnt += 1
            # print(d)

    print("Deals Count = %d" % (cnt))
    for verdict in verdict_names.keys():
        print("%-10s : %d" % (verdict_names[verdict], verdict_counts[verdict]))

    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv))
