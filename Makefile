ARCHIVE = vim-lang-ja
ARCHIVE_EXT = xz
ARCHIVE_DIR = $(ARCHIVE)
ARCHIVE_FILE = $(ARCHIVE).tar.$(ARCHIVE_EXT)

INSTALL_DIR = $(ARCHIVE)-runtime

archive: $(ARCHIVE_FILE)

archive-dir: $(ARCHIVE_DIR)

release: force-update-all
	@rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	$(MAKE) test
	$(MAKE) $(ARCHIVE_FILE)
	rm -rf $(ARCHIVE_DIR)

release-today:
	$(MAKE) release ARCHIVE=vim-lang-ja-`date +%Y%m%d`

test:
	$(MAKE) -C src/po test
	$(MAKE) -C runtime/lang test
	$(MAKE) -C runtime/tutor test

install: test
	mkdir -p $(INSTALL_DIR)/lang/ja/LC_MESSAGES
	mkdir -p $(INSTALL_DIR)/lang/ja.euc-jp/LC_MESSAGES
	mkdir -p $(INSTALL_DIR)/lang/ja.sjis/LC_MESSAGES
	mkdir -p $(INSTALL_DIR)/doc
	mkdir -p $(INSTALL_DIR)/tutor
	cp src/po/ja.mo $(INSTALL_DIR)/lang/ja/LC_MESSAGES/vim.mo
	cp src/po/ja.euc-jp.mo $(INSTALL_DIR)/lang/ja.euc-jp/LC_MESSAGES/vim.mo
	cp src/po/ja.sjis.mo $(INSTALL_DIR)/lang/ja.sjis/LC_MESSAGES/vim.mo
	cp runtime/lang/menu_ja*.vim $(INSTALL_DIR)/lang
	cp runtime/doc/*.UTF-8.1 $(INSTALL_DIR)/doc
	cp runtime/tutor/tutor.ja.* $(INSTALL_DIR)/tutor

clean:
	rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	rm -rf $(INSTALL_DIR)
	$(MAKE) -C src/po clean
	$(MAKE) -C runtime/lang clean
	$(MAKE) -C runtime/tutor clean

distclean: clean
	rm -f *.tar.bz2 *.tar.gz *.tar.xz

force-update-all: force-update-po force-update-lang force-update-tutor

force-update-po:
	$(MAKE) -C src/po force

force-update-lang:
	$(MAKE) -C runtime/lang force

force-update-tutor:
	$(MAKE) -C runtime/tutor force

$(ARCHIVE_DIR):
	mkdir -p $@/src/po
	mkdir -p $@/runtime/lang
	mkdir -p $@/runtime/doc
	mkdir -p $@/runtime/tutor
	cp src/po/*.po $@/src/po
	cp runtime/lang/menu_ja*.vim $@/runtime/lang
	cp runtime/doc/*.UTF-8.1 $@/runtime/doc
	cp runtime/tutor/tutor.ja.* $@/runtime/tutor

$(ARCHIVE).tar.gz: $(ARCHIVE_DIR)
	tar -czf $@ $<

$(ARCHIVE).tar.bz2: $(ARCHIVE_DIR)
	tar -cjf $@ $<

$(ARCHIVE).tar.xz: $(ARCHIVE_DIR)
	tar -cJf $@ $<
