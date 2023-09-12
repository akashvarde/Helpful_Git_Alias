PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin
DATAROOTDIR ?= $(PREFIX)/share
DATADIR ?= $(DATAROOTDIR)
MANDIR ?= $(DATAROOTDIR)/man 
# Directory containing the files to be installed
ALIAS_DIR := aliases
# Get a list of all files in the ALIAS_DIR with a .sh extension
EXEC_FILES := $(wildcard $(ALIAS_DIR)/*.sh)
.PHONY: check all install uninstall shellcheck shfmt

all:
	@echo "usage: make install"
	@echo "       make uninstall"

# install:
# 	mkdir -p $(BINDIR)
# 	install -m 0755 $(EXEC_FILES) $(BINDIR)

# uninstall:
# 	test -d $(BINDIR) && \
# 	cd $(BINDIR) && \
# 	rm -f $(EXEC_FILES)

##NEW INSTALL SCRIPT

# Install target
install:
    @echo "Installing scripts from $(pwd)"
	mkdir -p $(BINDIR)
	install -m 0755 $(EXEC_FILES) $(BINDIR)

# Uninstall target (optional)
# uninstall:
#     @echo "Uninstalling scripts from $(INSTALL_DIR)"
#     rm -f $(addprefix $(INSTALL_DIR)/,$(notdir $(SCRIPTS)))
#     @echo "Uninstallation complete"


check: shellcheck shfmt

shellcheck:
	./actions/shellcheck

shfmt:
	./actions/shfmt
