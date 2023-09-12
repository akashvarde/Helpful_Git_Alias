PREFIX ?= /usr/local
EXEC_PREFIX ?= $(PREFIX)
BINDIR ?= $(EXEC_PREFIX)/bin
DATAROOTDIR ?= $(PREFIX)/share
DATADIR ?= $(DATAROOTDIR)
MANDIR ?= $(DATAROOTDIR)/man
ALIAS_DIR = alias
# files that need mode 755
EXEC_FILES = git-standup

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
# List of scripts in the "alias" folder
SCRIPTS = $(wildcard $(ALIAS_DIR)/*)
# Install target
install: $(SCRIPTS)
    @echo "Installing scripts to $(INSTALL_DIR)"
    mkdir -p $(INSTALL_DIR)
    cp $^ $(INSTALL_DIR)
    chmod +x $(addprefix $(INSTALL_DIR)/,$(notdir $^))
    @echo "Installation complete"

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