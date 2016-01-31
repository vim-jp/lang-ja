default: ja.sjis.po ja.euc-jp.po

ja.sjis.po: ja.po
	@$(MAKE) sjiscorr
	rm -f ja.sjis.po
	iconv -f utf-8 -t cp932 ja.po | ./sjiscorr > ja.sjis.po

ja.euc-jp.po: ja.po
	iconv -f utf-8 -t euc-jp ja.po | \
		sed -e 's/charset=utf-8/charset=euc-jp/' -e 's/# Original translations/# Generated from ja.po, DO NOT EDIT/' > ja.euc-jp.po

sjiscorr: sjiscorr.c
	$(CC) -o sjiscorr sjiscorr.c

clean:
	rm -f sjiscorr sjiscorr.exe
