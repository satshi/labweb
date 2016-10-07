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

-  [MacTeX - TeX Users Group](https://tug.org/mactex/)を、もらってきてそのままインストールする。この段階で結構使い物になる。
-  [MacTeX - TeX Wiki](https://texwiki.texjp.org/?MacTeX)を参考にして設定をする。
- 日本語でヒラギノフォントを埋め込む場合、次のようにしてリンクを貼り、埋め込みの設定をする。El Capitan 用。

~~~

cd /usr/local/texlive/2016/texmf-dist/scripts/cjk-gs-integrate
sudo perl cjk-gs-integrate.pl --link-texmf --force
sudo mktexlsr
sudo kanji-config-updmap-sys hiragino-elcapitan-pron
~~~

一度やっておけばバージョンアップした時には、最後のkanji-config-updmap-sysのところだけやればよいはず。

### TeXShopで日本語

- アプリケーションフォルダの中のTeXフォルダの中のTeXShopを立ち上げる。古い場合は、アップデートする。
- メニューからTeXShop/環境設定を開く。
- 「書類」タブの一番下、設定プロファイルで「pTeX(ptex2pdf)」を選ぶ。
- あまり細かいことを気にしない場合は「タイプセット」タブの「デフォルトのスクリプト」を「Tex + DVI」にする。
- ほとんど英語しか使わないし、英語ではpdflatexを使いたいという方は、デフォルトで「Pdftex」にしておく。この場合、日本語を使う時はメニューのタイプセット/Tex + DVIを選択する。

### latexmk
TeXで必要な回数texをかけてくれたり、必要ならbibtexなども自動的にやってくれるツール。設定は ~/.latexmkrc に書く。以下、日本語はuplatex、英語はlualatexで synctexを使用する設定ファイル。ビューワーはSkimを使用。

```

$latex = 'uplatex %O -synctex=1 %S';
$pdflatex = 'pdflatex %O -synctex=1 %S';
$lualatex = 'lualatex %O -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 3;
$pvc_view_file_via_temporary = 0;
$pdf_previewer = 'open -ga /Applications/Skim.app';
```

### Atom + latextools + Skim
AtomをTeX用のエディタとして使用する。

- まず、パッケージ language-latex と latextools を導入する。
- latextoolsの設定でBuilder Setting Programをlualatexに変更。
- Skim は普通にインストールし、PDF-TeX同期サポートの初期値をAtomに設定する。

これで英語だけなら使い物になるはず。

- texファイルを読み込んで、cmd+option+b でタイプセット。タイプセットされ、エラーが無ければ、Skimが立ち上がる。
- Atom のtexのソースの方でcmd+l j でpdfの該当箇所に飛ぶ。pdf の方で cmd+shift+クリックで対応するtex のソースの場所に飛ぶ。
- latexの編集の補助は便利。詳しくはマニュアルを参照。
- 日本語を使う場合も luatex-ja でやるならそのままできる。

ptexを使う場合、次のようにすれば一応使える。

- 上のlatexmkの設定をする。
- latextools の２箇所を改造する。coffeescriptなので**インデントを変えない**ように注意。１箇所めは、
``~/.atom/packages/latextools/lib/builder.coffee``
の104行目
``whitelist = ["pdflatex", "xelatex", "lualatex"]``
を
``whitelist = ["pdflatex", "xelatex", "lualatex","pdfdvi"]``
に変更する。リストの最後に``"pdfdvi"``を追加した。
- ２箇所め。
``~/.atom/packages/latextools/lib/latextools.coffee``
の152行目
``enum: ["pdflatex", "xelatex", "lualatex"]``
を
``enum: ["pdflatex", "xelatex", "lualatex","pdfdvi"]``
に変更する。やはりリストの最後に``"pdfdvi"``を追加した。
- ptexを主に使うなら、atomを立ち上げなおし、latextoolsの設定のlatextoolsの設定でBuilder Setting Programをpdfdviに変更。
- ptexはたまにしか使わないなら、設定のところのBuilder Setting Programはlualatexのままにしておき、ptexを使いたい文書のtexファイルの先頭に``% !TEX program = pdfdvi``を入れる。

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
