ARCHIVE = vim-lang-ja-po
ARCHIVE_EXT = xz
ARCHIVE_DIR = $(ARCHIVE)
ARCHIVE_FILE = $(ARCHIVE).tar.$(ARCHIVE_EXT)

MASTER_PO = ja.po

POFILES = ja.po \
	  ja.euc-jp.po \
	  ja.sjis.po

MOFILES = ja.mo \
	  ja.euc-jp.mo \
	  ja.sjis.mo

CHECKFILES = ja.ck \
	     ja.euc-jp.ck \
	     ja.sjis.ck

MSGFMT = OLD_PO_FILE_INPUT=yes msgfmt

VIM = vim

.SUFFIXES: .po .mo .ck

test: check $(MOFILES)

release:
	@rm -rf $(ARCHIVE_DIR) $(ARCHIVE_FILE)
	$(MAKE) test
	$(MAKE) $(ARCHIVE_FILE)
	rm -rf $(ARCHIVE_DIR)

release-today:
	$(MAKE) release ARCHIVE=vim-lang-ja-po-`date +%Y%m%d`

update: ja.sjis.po ja.euc-jp.po

ja.sjis.po: $(MASTER_PO)
	@$(MAKE) sjiscorr
	rm -f $@
	iconv -f utf-8 -t cp932 $< | ./sjiscorr > $@

ja.euc-jp.po: $(MASTER_PO)
	iconv -f utf-8 -t euc-jp $< | \
	  sed -e 's/charset=[uU][tT][fF]-8/charset=euc-jp/' -e 's/# Original translations/# Generated from ja.po, DO NOT EDIT/' > $@

sjiscorr: sjiscorr.c
	$(CC) -o $@ $<

force: touch
	@$(MAKE) update

touch: $(MASTER_PO)
	touch $<

merge:
	rm -f ja.po.old
	mv ja.po ja.po.old
	msgmerge ja.po.old vim.pot -o ja.po

merge-force:
	touch vim.pot
	@$(MAKE) merge

clean: checkclean
	rm -f sjiscorr sjiscorr.exe
	rm -f ja.sjis.po ja.euc-jp.po
	rm -f *.mo

distclean: clean
	rm -f *.tar.bz2 *.tar.gz *.tar.xz

#ja.po: vim.pot
#	rm -f $@.old
#	mv $@ $@.old
#	msgmerge $@.old $< -o $@

.po.mo:
	$(MSGFMT) --check -v -o $@ $<

.po.ck:
	$(VIM) -u NONE --noplugins -e -s -X --cmd "set enc=utf-8" -S check.vim \
	  -c "if error == 0 | q | else | num 2 | cq | endif" $<
	touch $@

check: $(CHECKFILES)

checkclean:
	rm -f *.ck

$(ARCHIVE_DIR): $(POFILES)
	mkdir -p $@/src/po
	cp $(POFILES) $@/src/po

$(ARCHIVE).tar.gz: $(ARCHIVE_DIR)
	tar -czf $@ $<

$(ARCHIVE).tar.bz2: $(ARCHIVE_DIR)
	tar -cjf $@ $<

$(ARCHIVE).tar.xz: $(ARCHIVE_DIR)
	tar -cJf $@ $<
