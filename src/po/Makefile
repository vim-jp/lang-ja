MASTER_PO = ja.po
TEST_TARGETS = ja.mo \
	       ja.euc-jp.mo \
	       ja.sjis.mo

MSGFMT = OLD_PO_FILE_INPUT=yes msgfmt

.SUFFIXES: .po .mo

test: $(TEST_TARGETS)

update: ja.sjis.po ja.euc-jp.po

ja.sjis.po: $(MASTER_PO)
	@$(MAKE) sjiscorr
	rm -f $@
	iconv -f utf-8 -t cp932 $< | ./sjiscorr > $@

ja.euc-jp.po: $(MASTER_PO)
	iconv -f utf-8 -t euc-jp $< | \
	  sed -e 's/charset=utf-8/charset=euc-jp/' -e 's/# Original translations/# Generated from ja.po, DO NOT EDIT/' > $@

sjiscorr: sjiscorr.c
	$(CC) -o $@ $<

force: touch
	@$(MAKE) update

touch: $(MASTER_PO)
	touch $<

merge: ja.po

merge-force:
	touch vim.pot
	@$(MAKE) merge

clean:
	rm -f sjiscorr sjiscorr.exe
	rm -f ja.sjis.po ja.euc-jp.po
	rm -f *.mo

ja.po: vim.pot
	rm -f $@.old
	mv $@ $@.old
	msgmerge $@.old $< -o $@

.po.mo:
	$(MSGFMT) -v -o $@ $<
