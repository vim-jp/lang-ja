MASTER_TUTOR = tutor.ja.utf-8

test: update

update: tutor.ja.sjis tutor.ja.euc

tutor.ja.sjis: $(MASTER_TUTOR)
	iconv -f utf-8 -t cp932 < $< > $@

tutor.ja.euc: $(MASTER_TUTOR)
	iconv -f utf-8 -t euc-jp < $< > $@

force: touch
	@$(MAKE) update

touch: $(MASTER_TUTOR)
	touch $<

clean:
	rm -f tutor.ja.sjis tutor.ja.euc
