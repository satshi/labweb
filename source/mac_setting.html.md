---
layout: flat
title: Macの設定の覚書
lead:  
pageid: mac_setting
---

## 基本的なもの

### 日本語入力
ことえりは使いにくいので [Google 日本語入力](http://www.google.co.jp/ime/)を導入する。
## TeX

### MacTeX

- [MacTeX-2014(TeX Live 2014)](http://www.tug.org/mactex/)を、もらってきてそのままインストールする。この段階で結構使い物になる。
- [Mac - TeX Wiki](http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Mac#t244993f)を参考にして設定をする。
- 日本語でヒラギノフォントを埋め込む場合、次のようにしてリンクを貼り、埋め込みの設定をする。

~~~

sudo mkdir -p /usr/local/texlive/texmf-local/fonts/opentype/hiragino/
cd /usr/local/texlive/texmf-local/fonts/opentype/hiragino/
sudo ln -fs "/Library/Fonts/ヒラギノ明朝 Pro W3.otf" ./HiraMinPro-W3.otf
sudo ln -fs "/Library/Fonts/ヒラギノ明朝 Pro W6.otf" ./HiraMinPro-W6.otf
sudo ln -fs "/Library/Fonts/ヒラギノ丸ゴ Pro W4.otf" ./HiraMaruPro-W4.otf
sudo ln -fs "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" ./HiraKakuPro-W3.otf
sudo ln -fs "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" ./HiraKakuPro-W6.otf
sudo ln -fs "/Library/Fonts/ヒラギノ角ゴ Std W8.otf" ./HiraKakuStd-W8.otf
sudo mktexlsr
sudo updmap-sys --setoption kanjiEmbed hiragino
~~~

一度やっておけばバージョンアップした時には、最後のupdmap-sysのところだけやればよい。

### TeXShopで日本語

- アプリケーションフォルダの中のTeXフォルダの中のTeXShopを立ち上げる。古い場合は、アップデートする。ここで使ったのは、3.36.2
- メニューからTeXShop/環境設定を開く。
- 「書類」タブの一番下、設定プロファイルで「pTeX(ptex2pdf)」を選ぶ。
- あまり細かいことを気にしない場合は「タイプセット」タブの「デフォルトのスクリプト」を「Tex + DVI」にする。
- ほとんど英語しか使わないし、英語ではpdflatexを使いたいという方は、デフォルトで「Pdftex」にしておく。この場合、日本語を使う時はメニューのタイプセット/Tex + DVIを選択する。

##エディタ

### CotEditor
- [CotEditor -Text Editor for OS X](http://coteditor.github.io/)からもらってくる。普段使いに便利なエディタ。

### Atom
- [Atom](https://atom.io/)からもらってくる。高機能なエディタ。重い。

##Homebrew
パッケージマネージャーと呼ばれるソフト。いろんなものをインストールしたりアンインストールしたりする。まず、XCode（無料だけどでかい）をApp Storeからインストールしておくことが必要。
 [Homebrew — The missing package manager for OS X](http://brew.sh/)にいって、Homebrewを導入。

## お絵かき

### Inkscape
ドロー系のお絵かきソフトで論文などに入れる図を書くのに使う。Windowsの時は使いやすかったのだが、Macとは相性がそれほどよくないよう。

まず、今のところXが必要なので導入する。 [XQuartz](http://xquartz.macosforge.org/landing/)に行ってバイナリーをもらってくる。

次に
[Draw Freely. | Inkscape](http://www.inkscape.org/ja/)に行って、バイナリーをもらってくる。

- 趣味にもよるが、メニューなどを日本語にする。InkscapeのメニューのFile > Inkscape Preferencesを開き、InterfaceのところのLanguage をJapanese(ja)にし、Inkscape を再起動する。
- コピー・アンド・ペーストするとその部分がラスター画像になってしまう問題がある。解決するにはX11のメニューから「X11の環境設定」を開いて「ペーストボード」のタブの「CLIPBOARDが変更されたときにペーストボードをアップデート」のチェックをはずす。
- 数式を貼りたい。試した限りではLatexitからコピペは難しい。デフォルトで数式を扱うプラグインが入っているのでそれを使う。homebrewでpstoeditをインストールする。Inkscapeを再起動するとメニューのエクステンション＞レンダリング＞Latex数式を選ぶとダイアログが出てきてtexの書式で数式が書ける。何かエラーが出ているが、とりあえず書けるようにはなった。
- メニューなどのフォントがイマイチ。

###Gimp
こちらはペイントと画像処理のソフト。あまり使わないが時々必要なのインストールする。 [GIMP - The GNU Image Manipulation Program](http://www.gimp.org/)からもらってきて入れるだけ。

## FirefoxとThunderbird

普通にインストールして、Windowsから設定を持ってくるとそのまま使えた。

##小物

###文字コード変換
日本語のファイルの文字コードはすべてutf-8に統一しておくのが便利。 [MultiTextConverter](http://www.rk-k.com/software/mtc) を使っている。環境設定でsjisの機種依存文字のところをWindowsにする。でないと\を￥にされてしまう。あと、拡張子にtex, styを追加する。あとはフォルダーごとドラッグ・アンド・ドロップで変換してくれる。
