BIN_DIR := /usr/local/bin

all: install

install:
	cp lanip.sh $(BIN_DIR)/lanip
	cp wlanip $(BIN_DIR)/wlanip
	chmod 755 $(BIN_DIR)/lanip $(BIN_DIR)/wlanip
	@echo "lanip: installation completed."

uninstall:
	rm -f $(BIN_DIR)/lanip $(BIN_DIR)/wlanip
	@echo "lanip: uninstallation completed."

.PHONY: all install uninstall
