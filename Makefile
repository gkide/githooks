# Do not print "Entering directory ..."
MAKEFLAGS += --no-print-directory

all:
	@echo "Build done."

PHONY += release
release:
	@scripts/release GITHOOKS_RELEASE

PHONY += sync-repo-info
sync-repo-info:
	@scripts/sync-repo-info $(VCS)
