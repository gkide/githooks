# Do not print "Entering directory ..."
MAKEFLAGS += --no-print-directory

all:
	@echo "Build done."

PHONY += test-auto
test-auto:
	@scripts/test/run.sh AUTO

PHONY += test-user
test-user:
	@scripts/test/run.sh USER


PHONY += release
release:
	@scripts/repo-hooks.sh
