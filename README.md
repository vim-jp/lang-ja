# vim-jp/lang-ja

[![Join the chat at https://gitter.im/vim-jp/lang-ja](https://badges.gitter.im/vim-jp/lang-ja.svg)](https://gitter.im/vim-jp/lang-ja?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/vim-jp/lang-ja.svg?branch=master)](https://travis-ci.org/vim-jp/lang-ja)

Vimに付属する日本語翻訳ファイルを管理するリポジトリ

## ディレクトリ/ファイル 解説

パス                               |説明
-----------------------------------|-----
src/po/, runtime/lang              |Vimに付属の日本語翻訳ファイルが置いてあります。
src/po/ja.po                       |Vimのメッセージ翻訳ファイルのマスター(UTF-8)
runtime/lang/menu\_ja\_jp.utf-8.vim|Vimの日本語メニューファイルのマスター(UTF-8)
runtime/doc/\*-ja.UTF-8.1          |日本語manファイル(UTF-8)
runtime/doc/\*.1                   |原文manファイル
runtime/tutor/tutor.ja.utf-8       |日本語チュートリアルファイル(UTF-8)
runtime/tutor/tutor                |原文チュートリアルファイル

## ja.po 更新手順

1.  vim.pot を作成(要xgettext)

    Vimのソースで以下を実行して、生成される vim.pot を src/po へコピー

        $ cd src/po
        $ make vim.pot

    註: `make vim.pot` を実行するには `src/` で `./configure` を実行しておく必
    要があるが、`src/po/Makefile` の4行目の `include ../auto/config.mk` をコメ
    ントアウトして回避することも可能。(あるいは、空の `src/auto/config.mk` を用意してもよい。)

    Windows 上で vim.pot を生成するには、Cygwin や MSYS2 等の Linux 的な環境を使うこと。(MSVC 用の Makefile も用意されているが、ソースファイルの読み込み順序が異なるために余計な差分が出てしまう。)
    また、Win32 向けにビルドしたために `src/if_perl.c` が生成されているならば、vim.pot 生成前に削除しておくこと。(余計な差分が出るのを防ぐため。)

2.  ja.po に vim.pot をマージ (古いものは ja.po.old へ退避される)

        $ make merge

3.  ja.po のコピーライトやヘッダーを適宜修正

    これはPRを作るだけの場合は、やらないほうが良いかも。

4.  翻訳する

    Vimを使って下記の検索コマンドで翻訳すべき場所を探すと良い。

        /fuzzy\|^msgstr ""\(\n"\)\@!

5.  不要な情報の削除

    Vim で以下のようにする。

        :source cleanup.vim

    cleanup.vim は Vim 本体からのコピー (実行には Vim 8.0.0794 以降が必要)

6.  チェック

        $ vim -S check.vim ja.po

    `make check` でも代替可能。

7.  もう1回マージして、整形と消しすぎたコメントの復活

        $ make merge-force
        $ vim ja.po
        :source cleanup.vim
        :wq

## manファイル更新手順

1.  原文manファイルの更新

    Vimのソースファイルの runtime/doc/ ディレクトリから、原文manファイルを本リ
    ポジトリにコピー。

        $ cd /path/to/vim/runtime/doc
        $ cp evim.1 vim.1 vimdiff.1 vimtutor.1 xxd.1 /path/to/lang-ja/runtime/doc

2.  翻訳

    原文の差分を見つつ翻訳ファイルを更新する。

        $ git diff | gvim -R -

3.  表示確認

    以下のコマンドで表示を確認できる。

        $ groff -Tutf8 -Dutf8 -mandoc -mja vim-ja.UTF-8.1 | less -R

4.  コミット

    原文と日本語訳は常に同じバージョンがコミットされているように注意すること。

## チュートリアルファイル更新手順

1.  原文チュートリアルファイルの更新

    Vimのソースファイルの runtime/tutor/ ディレクトリから、原文チュートリアル
    ファイルを本リポジトリにコピー。

        $ cd /path/to/vim/runtime/tutor
        $ cp tutor /path/to/lang-ja/runtime/tutor

2.  翻訳

    原文の差分を見つつ翻訳ファイルを更新する。

        $ git diff | gvim -R -

3.  コミット

    原文と日本語訳は常に同じバージョンがコミットされているように注意すること。

## リリース手順

1.  各リソースが最新に近いことを確認する

    TODO: 将来、より具体的で自動化された手段を提供したい

2.  `PO-Revision-Date` を更新する

    ja.po のヘッダにある `PO-Revision-Date` を、リリース用に更新する。

3.  テストをパスする

        $ make test

    [CI][#ci] で実行しているのでローカルでやる意味は無いが、テストをパスするこ
    とを確認する。

4.  リリース用アーカイブを作成する

        $ make release-today

    `vim-lang-ja-20160131.tar.xz` といったアーカイブファイルができる。
    `20160131` の部分は実行した日付に置き換わる。
    
5.  タグを打ち、GitHub Releases を更新する

    タグの形式は YYYYMMDD とする。例:

        $ git tag 20181116 -m 'Catch up with 8.1.0519'
        $ git push origin master --tags

    タグが push できたら、GitHub Releases に新しいリリースを作り、アーカイブ
    をアップロードする。

6.  アーカイブを Bram と vim-dev へ送る

    あとはこのアーカイブファイルを Bram と vim-dev へ更新依頼とともに送信する。
    以下、文面の一例:

        Hi Bram and the list,

        I'd like to update Japanese translations.
        Could you merge the contents from the attached file into Vim?

        The same file is also available at the vim-jp/lang-ja repository:
        https://github.com/vim-jp/lang-ja/releases/tag/20181116

        Thanks,
        (ここにあなたの名前。`Takata`とか)


[#ci]:https://travis-ci.org/vim-jp/lang-ja
