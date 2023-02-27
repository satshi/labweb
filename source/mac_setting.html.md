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

- [MacTeX - TeX Users Group](https://tug.org/mactex/)を、もらってきてそのままインストールする。この段階で結構使い物になる。
- [MacTeX - TeX Wiki](https://texwiki.texjp.org/?MacTeX)を参考にして設定をする。まずはアップデート。

~~~ bash
sudo tlmgr update --self --all
~~~

紙のデフォルトをa4にする。

~~~ bash
sudo tlmgr paper a4
~~~

- 日本語でヒラギノフォントを埋め込む場合、[Bibunsho7-patch/Patch.app](https://github.com/munepi/bibunsho7-patch/)を使う。「LaTeX2e美文書作成入門の付録DVD-ROM内のMac OS X用インストーラーから、…」と書いてあるが、[MacTeX - TeX Users Group](https://tug.org/mactex/)のものをインストールした場合にこのパッチをあててもうまくいっている。


### latexmk

TeXで必要な回数texをかけてくれたり、必要ならbibtexなども自動的にやってくれるツール。設定は一番良く使うであろうものを ~/.latexmkrc に書く。
しかし、この設定ファイルに頼らずにプロジェクトごとに設定ファイルを置くべき。プロジェクトごとの設定ファイルは、プロジェクトのディレクトリ（普通texファイルが置いてあるディレクトリ）に`latexmk`というファイル（最初に.がついてないことに注意）。

以下設定ファイルの例。

1. 日本語でuplatexを使用する場合：
``` perl
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
```
2. 英語でpdflatexを使用する場合
``` perl
$latex = 'uplatex %O -synctex=1 %S';
$pdflatex = 'pdflatex %O -synctex=1 %S';
$lualatex = 'lualatex %O -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 1;
```
3. 日本語か英語でlualatexを使用する場合
``` perl
$latex = 'uplatex %O -synctex=1 %S';
$pdflatex = 'pdflatex %O -synctex=1 %S';
$lualatex = 'lualatex %O -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 4;
```

上の３つの例では、$pdfmode だけが異なる。platexの設定は書いてないが、uplatexでもよいならuplatexを使うべき。不幸にしてスタイルファイルを強制されているなどの理由でplatexを使わなければならない場合にはuplatexの設定の中の"upなんとか"を"pなんとか"に書き換えればよいはず。

### VSCode+latex-workshop

開発速度が比較的速いので、すぐ情報が古くなることに注意。以下2018年5月現在の情報。

まず、VSCodeを[Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)からもらってきてインストールする。

そしてパッケージlatex-workshopをインストールする。やり方は、次のとおり。

- VSCode を立ち上げ、左端に並んでいるボタンのうち一番下のもの（拡張機能の管理）を押す。
- そこでlatex-workshopを検索して「インストール」のところを押す。
- そして「再読み込み」のところを押す。

これで英語のlatexファイルなら使えるようになっているはず。cmd+shift+Pでコマンドパレットが開くので、latexと打つと、それ関係のコマンドが出てくる。ショートカットも表示されるので、よく使いそうなものは覚える。

スペルチェックがあると便利。私はSpell Rightというパッケージのを使っている。

日本語を編集するためには超えなければならない問題がある。一つは日本語変換で何かやっているときに間違ってコントロールキャラクターが入ってしまうことがあり、コンパイルのときにエラーが出る。これはVSCodeの（というかelectronの、あるいはChromiumの）バグで2018年5月現在直っていない。対処方法は次のようにコントロールキャラクターを表示する設定にすること。

- cmd+,で設定タブを開く。
- controlとかで検索して「既定のユーザー設定」の方の"editor.renderControlCharacters": false,という行を見つける。
- その行の先頭のへんにマウスカーソルを持っていくと鉛筆みたいな印が出るので、そこを押す。
- falseとtrueが出るのでtrueを押す。
- 右のユーザー設定の方にtrueになった設定がコピーされるので、それを保存する。

日本語をあつかうときにもう一つやらないといけないのは、texをコンパイルするときの設定。

- cmd+,で設定タブを開く。
- 検索して「既定のユーザー設定」の方の"latex-workshop.latex.recipes":…という行を見つける。
- その行の先頭のへんにマウスカーソルを持っていくと鉛筆みたいな印が出るので、そこを押す。
- 「設定にコピー」を押してユーザー設定の方にコピーする。
- 次のように書き換えて保存する。基本的にlatexmkのargsの中の"-pdf",という行を消しただけ。

```json
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "pdflatex",
      "command": "pdflatex",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "bibtex",
      "command": "bibtex",
      "args": [
        "%DOCFILE%"
      ]
    }
  ],
```

### TeXShopで日本語

（2023年2月追記：私はTeXShopを使ってないので以下の情報は古いです）

- アプリケーションフォルダの中のTeXフォルダの中のTeXShopを立ち上げる。古い場合は、アップデートする。
- メニューからTeXShop/環境設定を開く。
- 「書類」タブの一番下、設定プロファイルで「pTeX(ptex2pdf)」を選ぶ。
- あまり細かいことを気にしない場合は「タイプセット」タブの「デフォルトのスクリプト」を「Tex + DVI」にする。
- ほとんど英語しか使わないし、英語ではpdflatexを使いたいという方は、デフォルトで「Pdftex」にしておく。この場合、日本語を使う時はメニューのタイプセット/Tex + DVIを選択する。


## エディタ

### CotEditor

- App Storeからもらってくる。普段使いに便利なエディタ。

## Homebrew

パッケージマネージャーと呼ばれるソフト。いろんなものをインストールしたりアンインストールしたりする。まず、XCode（無料だけどでかい）をApp Storeからインストールしておくことが必要。
 [Homebrew — The missing package manager for OS X](http://brew.sh/)にいって、Homebrewを導入。

## お絵かき

### Inkscape

ドロー系のお絵かきソフトで論文などに入れる図を書くのに使う。Macでもだいぶ使いやすくなった。
[Draw Freely. | Inkscape](http://www.inkscape.org/ja/)に行って、バイナリーをもらってくる。

数式を貼りたい。試した限りではLatexitからコピペは難しい。デフォルトで数式を扱うプラグインが入っているのでそれを使う。Inkscapeを起動するときにterminalからやらなければならないっぽい？ terminal で``open -a Inkscape``と入力してリターン。そしてInkscapeのメニューのエクステンション＞レンダリング＞公式(pdflatex)を選ぶとダイアログが出てきてtexの書式で数式が書ける。

### Gimp

こちらはペイントと画像処理のソフト。あまり使わないが時々必要なのインストールする。 [GIMP - The GNU Image Manipulation Program](http://www.gimp.org/)からもらってきて入れるだけ。

## 小物

### 文字コード変換

日本語のファイルの文字コードはすべてutf-8に統一しておくのが便利。 [MultiTextConverter](http://www.rk-k.com/software/mtc) を使っている。環境設定でsjisの機種依存文字のところをWindowsにする。でないと\を￥にされてしまう。あと、拡張子にtex, styを追加する。あとはフォルダーごとドラッグ・アンド・ドロップで変換してくれる。
