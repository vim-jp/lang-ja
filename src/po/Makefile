MASTER_PO = ja.po

update: ja.sjis.po ja.euc-jp.po

ja.sjis.po: $(MASTER_PO)
	@$(MAKE) sjiscorr
	rm -f ja.sjis.po
	iconv -f utf-8 -t cp932 $< | ./sjiscorr > ja.sjis.po

ja.euc-jp.po: $(MASTER_PO)
	iconv -f utf-8 -t euc-jp $< | \
	  sed -e 's/charset=utf-8/charset=euc-jp/' -e 's/# Original translations/# Generated from ja.po, DO NOT EDIT/' > ja.euc-jp.po

sjiscorr: sjiscorr.c
	$(CC) -o sjiscorr sjiscorr.c

force: touch
	@$(MAKE) update

touch: $(MASTER_PO)
	touch $<

clean:
	rm -f sjiscorr sjiscorr.exe
