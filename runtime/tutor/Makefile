MASTER_TUTOR1 = tutor1.ja.utf-8

test: update

update: tutor1.ja.sjis tutor1.ja.euc

tutor1.ja.sjis: $(MASTER_TUTOR1)
	iconv -f utf-8 -t cp932 < $< > $@

tutor1.ja.euc: $(MASTER_TUTOR1)
	iconv -f utf-8 -t euc-jp < $< > $@

force: touch
	@$(MAKE) update

touch: $(MASTER_TUTOR1)
	touch $<

clean:
	rm -f tutor1.ja.sjis tutor1.ja.euc
