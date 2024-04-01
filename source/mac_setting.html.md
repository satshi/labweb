---
layout: flat
title: Macの設定の覚書
lead:  
pageid: mac_setting
---

## 基本的なもの

### 日本語入力

私は[Google 日本語入力](http://www.google.co.jp/ime/)を導入している。

### Homebrew

パッケージマネージャーと呼ばれるソフト。いろんなものをインストールしたりアンインストールしたりする。
 [Homebrew — The missing package manager for OS X](http://brew.sh/)に行って、Homebrewを導入。

## TeX

2023年現在[Overleaf](https://ja.overleaf.com/)を使うのが一番楽で安定しているようだ。ただ無料版だと履歴が1日分くらいしか残せないらしい。ローカルならgitで管理すれば、完全に履歴が残せる。それ以外にもオフラインでも使いたいとか、手元にないと何となく不安とかあるので、本格的にTeXを使うならローカルにインストールしておくほうがいい気もする。

以下、ローカルで使いたい人向け。

### MacTeX

[MacTeX - TeX Wiki](https://texwiki.texjp.org/?MacTeX)を参考にしてインストールや設定をする。
私は最近はhomebrewでインストールしている。以下、homebrewはインストールされているとして、ターミナルで以下のコマンドを打ち込んでいく。

1. まず、MacTeXのインストール。時間がかかるし、途中でパスワードを求められることもある。

    ```sh
    brew install --cask mactex
    ```

    ここで一旦ターミナルを再起動する必要があるらしい。

2. アップデート。これも時間がかかる場合がある。

    ```sh
    sudo tlmgr update --self --all
    ```

3. デフォルトの紙をA4にする。

    ```sh
    sudo tlmgr paper a4
    ```

### latexmk

TeXで必要な回数texをかけてくれたり、必要ならbibtexなども自動的にやってくれるツール。設定は一番良く使うであろうものを ~/.latexmkrc に書く。
しかし、この設定ファイルに頼らずにプロジェクトごとに設定ファイルを置くべき。プロジェクトごとの設定ファイルは、プロジェクトのディレクトリ（普通texファイルが置いてあるディレクトリ）に`latexmk`というファイル（最初に.がついてないことに注意）。

以下設定ファイルの例（2023年3月ちょくちょく変えてます）。

1. 日本語でuplatexを使用する場合：

    ``` perl
    $texoption = ' %O -interaction=nonstopmode -file-line-error -synctex=1 %S';
    $latex = 'uplatex'.$texoption;
    $pdflatex = 'pdflatex'.$texoption;
    $lualatex = 'lualatex'.$texoption;
    $biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
    $bibtex = 'pbibtex %O %B';
    $makeindex = 'mendex %O -o %D %S';
    $dvipdf = 'dvipdfmx %O -o %D %S';
    $pdf_mode = 3;
    ```

2. 英語でpdflatexを使用する場合

    ``` perl
    $texoption = ' %O -interaction=nonstopmode -file-line-error -synctex=1 %S';
    $latex = 'uplatex'.$texoption;
    $pdflatex = 'pdflatex'.$texoption;
    $lualatex = 'lualatex'.$texoption;
    $biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
    $bibtex = 'pbibtex %O %B';
    $makeindex = 'mendex %O -o %D %S';
    $dvipdf = 'dvipdfmx %O -o %D %S';
    $pdf_mode = 1;
    ```

3. 日本語か英語でlualatexを使用する場合

     ``` perl
    $texoption = ' %O -interaction=nonstopmode -file-line-error -synctex=1 %S';
    $latex = 'uplatex'.$texoption;
    $pdflatex = 'pdflatex'.$texoption;
    $lualatex = 'lualatex'.$texoption;
    $biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
    $bibtex = 'pbibtex %O %B';
    $makeindex = 'mendex %O -o %D %S';
    $dvipdf = 'dvipdfmx %O -o %D %S';
    $pdf_mode = 4;
    ```

上の３つの例では、$pdfmode だけが異なる。platexの設定は書いてないが、uplatexでもよいならuplatexを使うべき。不幸にしてスタイルファイルを強制されているなどの理由でplatexを使わなければならない場合にはuplatexの設定の中の"upなんとか"を"pなんとか"に書き換えればよいはず。

使い方は、プロジェクトのディレクトリで texファイルが１つしかない場合は
    ``
    latexmk
    ``
と入力することでビルドできる。texファイルがたくさんある場合は
    ``
    latexmk (ビルドしたいファイル名)
    ``
とする。

### VSCode+latex-workshop

開発速度が比較的速いので、すぐ情報が古くなることに注意。以下2023年3月現在の情報。

まず、VSCodeを[Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)からもらってきてインストールする。

そしてパッケージlatex-workshopをインストールする。やり方は、次のとおり。

- VSCode を立ち上げ、左端に並んでいるボタンのうち一番下のもの（拡張機能の管理）を押す。
- そこでlatex-workshopを検索して「インストール」のところを押す。
- そして「再読み込み」のところを押す。

これで英語でpdflatexなら使えるようになっているはず。cmd+shift+Pでコマンドパレットが開くので、latexと打つと、それ関係のコマンドが出てくる。ショートカットも表示されるので、よく使いそうなものは覚える。

スペルチェックがあると便利。私はLTeXというパッケージを使っている。これは簡単な文法チェックもやってくれるもの。

日本語を使いたい場合、あるいは日本語と英語を両方使いたい場合には、少し設定が必要。歴史的な理由からcmd+option+bでのビルドのデフォルトはlatexmkだけれど強制的にpdflatexでやるものになっている。昔はこれを書きかえなければならなかったが、今はlatexmkrc読んでビルドするレシピ``latexmk (latexmkrc)``が元からついているのでこれを使うのが一番安定。次のようにする。

- 上のlatexmkの設定をやる。
- cmd+, で設定を開く。"latex recipe"とかで検索してLatex-workshop>Latex>Recipe:Defaultの項目を探す。ここを``latexmk (latexmkrc)``に書き換える。これで、cmd+option+bでlatexmk(latexmkrc)のレシピでビルドできる。
- 好みで Latex-workshop>Latex>Auto Build: Runのところも変える。私はonSaveにしている。

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

## お絵かき

### Inkscape

[Inkscape](http://www.inkscape.org/ja/)は、ドロー系のお絵かきソフトで論文などに入れる図を書くのに使う。Macでもだいぶ使いやすくなった。Homebrewでinstallできる。

```sh
brew install --cask inkscape
```

数式を貼りたい場合、以下のような方法が可能。

- デフォルトで数式を扱うプラグインが入っているのでそれを使う。Inkscapeを起動するときにterminalからやらなければならないっぽい？ terminal で`open -a Inkscape`と入力してリターン。そしてInkscapeのメニューのエクステンション＞レンダリング＞公式(pdflatex)を選ぶとダイアログが出てきてtexの書式で数式が書ける。
- [TexText](https://textext.github.io/textext/)を使う。再編集が可能。しかし私が試した限り日本語キーボードから\を入力するのがめんどい。何も考えないと¥が出てくる。新しいものはTypstも使える。

### Gimp

こちらはペイントと画像処理のソフト。あまり使わないが時々必要なのインストールする。 [GIMP - The GNU Image Manipulation Program](http://www.gimp.org/)からもらってきて入れるだけ。

## 小物

### 文字コード変換

2024年3月追記：ここ数年、utf-8以外の文字コードにはほとんど出会っていないので、もう文字コードを変換する必要は無いのかもしれない。必要になれば、エディタで読み込んで変換してセーブ、というので対応できそう。以下は古い情報。

日本語のファイルの文字コードはすべてutf-8に統一しておくのが便利。 [MultiTextConverter](http://www.rk-k.com/software/mtc) を使っている。環境設定でsjisの機種依存文字のところをWindowsにする。でないと\を￥にされてしまう。あと、拡張子にtex, styを追加する。あとはフォルダーごとドラッグ・アンド・ドロップで変換してくれる。
