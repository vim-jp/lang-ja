MASTER_MENU = menu_ja_jp.utf-8.vim

test:

update: menu_ja_jp.euc-jp.vim menu_japanese_japan.932.vim

menu_ja_jp.euc-jp.vim: $(MASTER_MENU)
	iconv -f utf-8 -t euc-jp $< | \
	  sed -e 's/^scriptencoding utf-8/scriptencoding euc-jp/' -e 's/Menu Translations:\tJapanese (UTF-8)/Menu Translations:\tJapanese (EUC-JP)/' > $@

menu_japanese_japan.932.vim: $(MASTER_MENU)
	iconv -f utf-8 -t cp932 $< | \
	  sed -e 's/^scriptencoding utf-8/scriptencoding cp932/' -e 's/Menu Translations:\tJapanese (UTF-8)/Menu Translations:\tJapanese (CP932)/' > $@

force: touch
	@$(MAKE) update

touch: $(MASTER_MENU)
	touch $<

clean:
	rm -f menu_ja_jp.euc-jp.vim menu_japanese_japan.932.vim
