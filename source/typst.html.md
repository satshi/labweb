---
layout: flat
title: Typst： 使えそうなLaTeXの代替
lead:
pageid: typst
---
## Typstについて

TypstはLaTeXに似た組版ソフトです。私も少し使ってみて、結構気に入ったので広めたいと思って、このページを作りました。次のような特徴があります。

- 導入が楽。
- 書き方が比較的シンプル。
- タイプセットが速い。
- エラーメッセージが分かりやすい。

2024年１月現在、英語でも日本語でも、自分一人で使うならそれほど不便や違和感を感じないくらいには、完成しています。

Typstに関する情報は、例えば次のところから得られます。

- 公式ページ [Typst: Compose papers faster](https://typst.app/)
- ドキュメント [Typst Documentation](https://typst.app/docs/)
- Typstの様々な情報へのリンク集 [Awesome Typst Links](https://github.com/qjcg/awesome-typst)

## 導入
Typstを使いたい場合、一番お手軽なのはオンラインアプリ [Typst](https://typst.app/)を使うことです。フォントなどは、代表的なものが入っているので、通常の使い方で困ることは少ないと思います。

ローカルで使いたい場合、例えばvscodeの中で使うなら"Typst LSP"というパッケージを導入すれば、使えます。

コマンドラインで使いたい場合には、例えばMacでhomebrewを入れている場合には

```bash
brew install typst
```

で済みます。詳しくは [GitHub - typst/typst](https://github.com/typst/typst)を見てください。

ローカルで使う場合には、システムにインストールされているフォントを使うことができます。使いたいフォントがあれば、システムにインストールすることで使うことができます。

## 使い方

### Hello world

英語ならHello worldは非常に簡単です。おまじないは必要ありません。

```typst
Hello world😀
```

出力結果
![HelloWorldの出力結果](img/typstHelloWorld.png)

個人的に好きなのは、ユニコードの文字もそのまま書けば出力できるところです。

日本語の場合は何も考えずにやると少し変になります。

```typst
こんにちは、世界。
```

出力結果
![日本語のこんにちは世界の出力結果デフォルト](img/typstjpHelloWorld0.png)

日本語を正しく出すには、少しおまじないが必要です。

```typst
#set text(lang:"ja")
こんにちは、世界。
```
出力結果
![日本語のこんにちは世界の出力結果改善](img/typstjpHelloWorld1.png)
