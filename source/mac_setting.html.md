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

TeX関係は[LaTeXの導入](tex.html)に移動した。

## エディタ

### VSCode

[Visual Studio Code - Code Editing. Redefined](https://code.visualstudio.com/)に行ってダウンロードしてインストールする。TeX関係は[LaTeXの導入](tex.html)にまとめた。

### CotEditor

App Storeからもらってくる。普段使いに便利なエディタ。

## 小物

### 文字コード変換

2024年3月追記：ここ数年、utf-8以外の文字コードにはほとんど出会っていないので、もう文字コードを変換する必要は無いのかもしれない。必要になれば、エディタで読み込んで変換してセーブ、というので対応できそう。以下は古い情報。

日本語のファイルの文字コードはすべてutf-8に統一しておくのが便利。 [MultiTextConverter](http://www.rk-k.com/software/mtc) を使っている。環境設定でsjisの機種依存文字のところをWindowsにする。でないと\を￥にされてしまう。あと、拡張子にtex, styを追加する。あとはフォルダーごとドラッグ・アンド・ドロップで変換してくれる。
