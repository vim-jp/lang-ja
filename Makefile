ARCHIVE = vim-lang-ja
ARCHIVE_EXT = xz
ARCHIVE_DIR = $(ARCHIVE)
ARCHIVE_FILE = $(ARCHIVE).tar.$(ARCHIVE_EXT)

VIM_SRC_DIR =

INSTALL_DIR = $(ARCHIVE)-runtime

.PHONY: import-en-files update-src-dir \
	archive archive-dir release release-today test install clean distclean \
	force-update-all force-update-po force-update-lang force-update-tutor


# Import English files from the specified Vim source directory.
import-en-files:
	@if test ! -d "$(VIM_SRC_DIR)"; then echo VIM_SRC_DIR not specified; exit 1; fi
	$(MAKE) -C "$(VIM_SRC_DIR)"/src/po/ vim.pot
	cp "$(VIM_SRC_DIR)"/src/po/vim.pot src/po/
	cp "$(VIM_SRC_DIR)"/runtime/doc/evim.1 \
		"$(VIM_SRC_DIR)"/runtime/doc/vim.1 \
		"$(VIM_SRC_DIR)"/runtime/doc/vimdiff.1 \
		"$(VIM_SRC_DIR)"/runtime/doc/vimtutor.1 \
		"$(VIM_SRC_DIR)"/runtime/doc/xxd.1 \
		runtime/doc/
	cp "$(VIM_SRC_DIR)"/runtime/tutor/tutor runtime/tutor/
	cp "$(VIM_SRC_DIR)"/nsis/lang/english.nsi nsis/lang/

# Update Vim source directory.
update-src-dir:
	@if test ! -d "$(VIM_SRC_DIR)"; then echo VIM_SRC_DIR not specified; exit 1; fi
	@rm -rf $(ARCHIVE_DIR)
	$(MAKE) test
	$(MAKE) $(ARCHIVE_DIR)
	cp -rf $(ARCHIVE_DIR)/* "$(VIM_SRC_DIR)"
	rm -rf $(ARCHIVE_DIR)


archive: $(ARCHIVE_FILE)

archive-dir: $(ARCHIVE_DIR)

# Create release package with the specified archive name.
release: force-update-all
	@rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	$(MAKE) test
	$(MAKE) $(ARCHIVE_FILE)
	rm -rf $(ARCHIVE_DIR)

# Create release package based on today's date.
release-today:
	$(MAKE) release ARCHIVE=vim-lang-ja-`date +%Y%m%d`

test:
	$(MAKE) -C src/po test
	$(MAKE) -C runtime/doc test
	$(MAKE) -C runtime/lang test
	$(MAKE) -C runtime/tutor test

# Install the message files into the specified (runtime) directory.
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
	$(MAKE) -C runtime/doc clean
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
	mkdir -p $@/nsis/lang
	cp src/po/*.po $@/src/po
	cp runtime/lang/menu_ja*.vim $@/runtime/lang
	cp runtime/doc/*.UTF-8.1 $@/runtime/doc
	cp runtime/tutor/tutor.ja.* $@/runtime/tutor
	cp nsis/lang/japanese.nsi $@/nsis/lang

$(ARCHIVE).tar.gz: $(ARCHIVE_DIR)
	tar -czf $@ $<

$(ARCHIVE).tar.bz2: $(ARCHIVE_DIR)
	tar -cjf $@ $<

$(ARCHIVE).tar.xz: $(ARCHIVE_DIR)
	tar -cJf $@ $<
