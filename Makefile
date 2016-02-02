ARCHIVE = vim-lang-ja
ARCHIVE_EXT = xz
ARCHIVE_DIR = $(ARCHIVE)
ARCHIVE_FILE = $(ARCHIVE).tar.$(ARCHIVE_EXT)

archive: $(ARCHIVE_FILE)

archive-dir: $(ARCHIVE_DIR)

release: force-update-all
	@rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	$(MAKE) $(ARCHIVE_FILE)
	rm -rf $(ARCHIVE_DIR)

clean:
	rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	$(MAKE) -C src/po clean
	$(MAKE) -C runtime/lang clean
	$(MAKE) -C runtime/tutor clean

distclean: clean
	rm -f *.tar.bz2 *.tar.gz *.tar.xz

force-update-all: force-update-po force-update-lang force-update-tutor

force-update-po:
	cd src/po && $(MAKE) force

force-update-lang:
	cd runtime/lang && $(MAKE) force

force-update-tutor:
	cd runtime/tutor && $(MAKE) force

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
