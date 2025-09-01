MASTER_TUTOR1 = tutor1.ja.utf-8
MASTER_TUTOR2 = tutor2.ja.utf-8
MASTER_ALL = $(MASTER_TUTOR1) $(MASTER_TUTOR2)

test: update

update: tutor1.ja.sjis tutor1.ja.euc \
	tutor2.ja.sjis tutor2.ja.euc

# tutor1
tutor1.ja.sjis: $(MASTER_TUTOR1)
	iconv -f utf-8 -t cp932 < $< > $@

tutor1.ja.euc: $(MASTER_TUTOR1)
	iconv -f utf-8 -t euc-jp < $< > $@

# tutor2
tutor2.ja.sjis: $(MASTER_TUTOR2)
	iconv -f utf-8 -t cp932 < $< > $@

tutor2.ja.euc: $(MASTER_TUTOR2)
	iconv -f utf-8 -t euc-jp < $< > $@

force: touch
	@$(MAKE) update

touch: $(MASTER_ALL)
	touch $(MASTER_ALL)

clean:
	rm -f tutor1.ja.sjis tutor1.ja.euc
	rm -f tutor2.ja.sjis tutor2.ja.euc
