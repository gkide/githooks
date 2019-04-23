# Do not print "Entering directory ..."
MAKEFLAGS += --no-print-directory

all:
	@echo "Build done."

PHONY += test
test:
	@scripts/test/run.sh

PHONY += release
release:
	@scripts/repo-hooks.sh
