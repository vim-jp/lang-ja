MASTER_MENU = menu_ja_jp.utf-8.vim

SED = LANG=C sed

test: update

update: menu_ja_jp.euc-jp.vim menu_japanese_japan.932.vim

menu_ja_jp.euc-jp.vim: $(MASTER_MENU)
	iconv -f UTF-8 -t EUC-JP $< | \
		$(SED) -e 's/scriptencoding utf-8/scriptencoding euc-jp/' \
			-e 's/" Original translations/" Generated from $<, DO NOT EDIT/' \
			-e 's/\(" Menu Translations:.*\)(.*)/\1(EUC-JP)/' \
			> $@

menu_japanese_japan.932.vim: $(MASTER_MENU)
	iconv -f UTF-8 -t CP932 $< | \
		$(SED) -e 's/scriptencoding utf-8/scriptencoding cp932/' \
			-e 's/" Original translations/" Generated from $<, DO NOT EDIT/' \
			-e 's/\(" Menu Translations:.*\)(.*)/\1(CP932)/' \
			> $@

force: touch
	@$(MAKE) update

touch: $(MASTER_MENU)
	touch $<

clean:
	rm -f menu_ja_jp.euc-jp.vim menu_japanese_japan.932.vim
