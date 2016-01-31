ARCHIVE = vim-lang-ja
ARCHIVE_EXT = xz
ARCHIVE_DIR = $(ARCHIVE)
ARCHIVE_FILE = $(ARCHIVE).tar.$(ARCHIVE_EXT)

archive: $(ARCHIVE_FILE)

release: force-update-all
	@rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	$(MAKE) $(ARCHIVE_FILE)
	rm -rf $(ARCHIVE_DIR)

clean:
	rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)

distclean: clean
	rm -f *.tar.bz2 *.tar.gz *.tar.xz

force-update-all: force-update-po force-update-lang

force-update-po:
	cd src/po && $(MAKE) force

force-update-lang:
	cd runtime/lang && $(MAKE) force

$(ARCHIVE_DIR):
	mkdir -p $@/src/po
	mkdir -p $@/runtime/lang
	mkdir -p $@/runtime/doc
	cp src/po/*.po $@/src/po
	cp runtime/lang/menu_ja*.vim $@/runtime/lang
	cp runtime/doc/*.UTF-8.1 $@/runtime/doc

$(ARCHIVE).tar.gz: $(ARCHIVE_DIR)
	tar -czf $@ $<

$(ARCHIVE).tar.bz2: $(ARCHIVE_DIR)
	tar -cjf $@ $<

$(ARCHIVE).tar.xz: $(ARCHIVE_DIR)
	tar -cJf $@ $<
