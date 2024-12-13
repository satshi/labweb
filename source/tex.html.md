---
layout: flat
title: LaTeXの導入
lead:  
pageid: tex
---


## はじめに

素粒子理論分野で論文を書くときには、多くの場合LaTeXが使われます。LaTeXは現在の基準ではお世辞にも使いやすいソフトとは言えませんが「みんなが使っている」ということと「代替品が無い」という理由で、現在でもこの分野の論文はほぼすべてLaTeXで書かれています。この状況はおそらく今後も長く変わらないでしょう。

2024年現在ではWebアプリである[Overleaf](https://ja.overleaf.com/)を使うのが一番楽で安定しているようです。なので、とりあえずLaTeXを使ってみようという人はOverleafを使うことをおすすめします。ただOverleafは、無料版だと履歴が1日分くらいしか残せないとか、コンパイルが遅い等々不満点もあるようです。また共同研究などでGithubを使って共同で論文を書く場合には無料版だとできない（未確認）ので共同研究者がOverleafを使ってくれない場合にはローカルにインストールする必要があると思います。

ここでは、そういう必要にせまられてローカルでLaTeXの環境を構築する人のために、なるべく最短で使えるようになるようにインストールや設定のしかたなどを説明します。念頭においているのは、科学分野の学生や研究者で英語の論文をLaTeXで書くし、日本語の書類もLaTeXで書く場合もあり、共同執筆することもある人です。OSはMacで説明しています。

## VSCode

### インストールと基本的な設定

まずはVSCodeをインストールします。
[Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)に行ってダウンロードしてきて、指示にしたがってインストールします。

起動したらお好みにより日本語化します。VSCodeで絶対に覚えるべきショートカットは ⌘+⇧+P です。ここからすべてのメニューに行くことができます。さて、⌘+⇧+Pを押して“display”と打ってみるとメニューで“Configure display language”というのが出てくるので、それを選びます。そこから日本語を選ぶと拡張機能をダウンロードしてメニューなどを日本語に設定してくれます。

他の設定は⌘+,（コンマ）を押すことで行けます。おそらくこの段階で設定したいと思うことの一つはフォントの大きさでしょう。検索するなどしてEditor:Font Sizeを見つけて、お好みの値に設定してください。

### ターミナル

LaTeXなどを用いる場合、ターミナルを使うことは避けることが難しいです。なのでここでは最低限の使い方を説明します。ターミナルを使うことに慣れている方はここは読み飛ばしてください。

VSCodeにはターミナルが内蔵されています。⌘+j で下部にターミナルのタブが開きます。下部にターミナルではないものが開いている場合には、その枠の上のところの「ターミナル」と書いてあるところを押してください。

ターミナルの使い方の基本は、コマンドを打ち込んで↵キーを押すとそのコマンドを実行するというものです。

## TeX Live

TeXの「本体」とライブラリ等すべてまとめたものはTeX Liveと呼ばれて配布されているので、これをインストールします。Macの場合は、TeX Liveに他に有用なソフトをまとめてMacTeXという名前で配布されています。[MacTeX - TeX Wiki](https://texwiki.texjp.org/?MacTeX)にインストールや設定のしかたの説明があります。

以下はhomebrewを用いたインストールを説明します。

### Homebrew

Homebrewをインストールします。すでにHomebrewがインストールされている方は、ここは飛ばしてください。インストールされているかどうかは、ターミナルで``brew``と入力してみると分かります。使い方が表示されればインストールされています。「コマンドがない」という趣旨のエラーが出たらインストールされていません。

インストールの仕方は[Homebrew — The missing package manager for OS X](http://brew.sh/)に行って、その指示に従ってください。基本的にコマンドをターミナルにコピペして入力することでインストールされます。

### MacTeX

Homebrewが準備できたらMacTeXのインストールを行います。次のようにターミナルに入力していくことで、インストールできます。

1. MacTeXのインストールをします。これは非常に長い時間（2時間くらい？）かかります。途中でパスワードを求められることもあります。

    ```sh
    brew install --cask mactex
    ```

    ここで一旦ターミナルを再起動する必要があるらしいです。

2. アップデートをします。これも時間がかかる場合があります。

    ```sh
    sudo tlmgr update --self --all
    ```

3. デフォルトの紙をA4にします。

    ```sh
    sudo tlmgr paper a4
    ```

## 必要な設定

### latexmk

TeXで必要な回数texをかけてくれたり、必要ならbibtexなども自動的にやってくれるツールです。基本的に下で説明するlatex-workshopの中から使います。

latexmkを使うためには、設定ファイルを書く必要があります。一番良く使うであろうものを ~/.latexmkrc に書きます。VSCodeのメニューのファイル＞新しいテキストファイルを選びます。そして次の設定をコピペします。

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

できたら⌘+sを押して保存します。保存場所とファイル名を選ぶので次のようにしてください。

- ファイル名: ".latexmkrc" （最初に.（ピリオド）があることに注意）
- 場所：ホームディレクトリ（ユーザー名がついているフォルダで家のアイコンがついているもの）

### latex-workshopのインストール

VSCodeのパッケージlatex-workshopをインストールします。やり方は、次のとおりです。

- VSCode を立ち上げ、左端に並んでいるボタンのうち一番下のもの（拡張機能の管理）を押す。
- そこでlatex-workshopを検索して「インストール」のところを押す。
- そして「再読み込み」のところを押す。

### テスト

ここまでで最低限必要な設定が終わったので、動くかどうかテストしてみましょう。

- VSCodeのメニューからファイル＞フォルダを開くを選択し、適当なところ（分からなければ「書類」の直下）に“latextest”という新しいフォルダを作って開いてください。
- VSCodeのウインドウの右に立てに並んでいるアイコンのうち、一番上の書類っぽいアイコンを押して「エクスプローラー」を開いてください。
- エクスプローラーのlatextestの下の空いているところを右クリックし、コンテキストメニューから「新しいファイル」を選んでください。ファイル名を入力するようになるので、“test.tex”としてください。ファイルが開いて編集できるようになると思います。
- このファイルに次をコピペして保存してください。

  ``` latex
  \documentclass{jlreq}
  \begin{document}
  こんにちは世界！
  \end{document}
  ```

- VSCodeの右の縦に並んでいるアイコンの中にTEXというのがあると思うので、これを押してください。すると、LATEXというののいろんなメニューが出てきます。
- このメニューのコマンドの中から、「LaTeXプロジェクトをビルド」と書いてあるところの一番左の>を押してください。するとサブメニューが開くと思います。
- その中から「レシピ: latexmk (latexmkrc)」を選んでください。コンパイルされます。
- 「LaTeX PDFを表示」の中のサブメニューの「VSCodeタブで表示」を選んでください。右に新しいタブが開いて、出来上がった「こんにちは世界！」と書かれたpdfが表示されれば成功です。

### ショートカット

コンパイルする際に、いちいちメニューからやっていると面倒くさいです。なのでショートカットから正しくコンパイルできるようにします。

- ⌘+, で設定を開きます。
- "latex recipe"とかで検索してLatex-workshop>Latex>Recipe:Defaultの項目を探す。ここを``latexmk (latexmkrc)``に書き換えます。

これで、⌘+⌥+bでコンパイルできるようになります。

この他にも、次のようなショートカットはよく使います。

- ⌘+⌥+vでpdfの表示。
- texファイルで、⌘+⌥+jでカーソルの位置に対応するpdfの位置に飛ぶ。
- 表示されているpdfファイル内を⌘+クリックで、クリックした場所に対応するtexファイルの場所に飛ぶ。
- ⌘+⌥+cで、中間ファイルの削除。

他にも⌘+⇧+Pでコマンドパレットが開いてlatexで検索すると関係するコマンドが出てきます。ここにはショートカットも表示されるので、よく使いそうなものは覚えると便利です。

### latexmkrc

latexmkの設定ファイルは上で書いた~/.latexmkrcの他にtexファイルと同じフォルダにあるlatexmkrcのファイルに書くこともできます。ファイル名の先頭のピリオドのあるなしに注意してください。texファイルと同じフォルダにある方が優先されます。

これを利用して、texの文書ごとに異なるコンパイルの仕方を設定することができます。むしろ、デフォルトに頼らず、文書ごとにlatexmkrcを書くべきです。これは誰かにtexのソースを渡したり、共同執筆したりするときに、必ず書いた人が意図した方法でコンパイルされるようにするためです。

以下にいくつか設定ファイルの例を示します（2024年12月ちょくちょく変えてます）。

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

上の３つの例では、$pdfmode だけが異なります。platexの設定は書いていませんが、uplatexでもよいならuplatexを使うべきです。不幸にしてスタイルファイルを強制されているなどの理由でplatexを使わなければならない場合にはuplatexの設定の中の"upなんとか"を"pなんとか"に書き換えればよいはずです。

### pdflatexのテスト

arXivに投稿する論文はpdflatexで正しくコンパイルされるようにtexファイルを準備すべきです。

### スペルチェック

スペルチェックがあると便利です。私はVSCodeの拡張機能のLTeX+というパッケージを使っています。これは簡単な文法チェックもやってくれるものです。

## 図の作成

### Inkscape

[Inkscape](http://www.inkscape.org/ja/)は、ドロー系のお絵かきソフトで論文などに入れる図を書くのに使う。Macでもだいぶ使いやすくなった。Homebrewでinstallできる。

```sh
brew install --cask inkscape
```

数式を貼りたい場合、以下のような方法が可能。

- デフォルトで数式を扱うプラグインが入っているのでそれを使う。Inkscapeを起動するときにterminalからやらなければならないっぽい？ terminal で`open -a Inkscape`と入力してリターン。そしてInkscapeのメニューのエクステンション＞レンダリング＞公式(pdflatex)を選ぶとダイアログが出てきてtexの書式で数式が書ける。
- [TexText](https://textext.github.io/textext/)を使う。再編集が可能。しかし私が試した限り日本語キーボードから\を入力するのがめんどい。何も考えないと¥が出てくる。新しいものはTypstも使える。
