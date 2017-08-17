all: summarize

THEO_PRIN_REPO_DIR = $(HOME)/Download/unpack/games/freecell/freecell-pro-3fc-resolve-intractable-deals
THEO_PRIN_PROC = from-theo-prin
THEO_PRIN_LOGS = $(THEO_PRIN_PROC)/results-up-to-4-billion.txt $(THEO_PRIN_PROC)/results-up-to-5-billion.txt

summarize: $(THEO_PRIN_LOGS)


$(THEO_PRIN_LOGS): $(THEO_PRIN_PROC)/%: $(THEO_PRIN_REPO_DIR)/%
	mkdir -p $(THEO_PRIN_PROC)
	perl process-theodore-pringle-logs.pl < $< > $@
