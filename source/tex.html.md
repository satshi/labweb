---
layout: flat
title: TeXについて
lead:
pageid: tex
---
## なぜTeX

みんな使ってるから

## TeXのインストール

## Vscode

## GitとGithub

## Tips

以下一応uplatex、あるいはpdflatexでの例。他のものでも、それほど違わないと思う。

### Hello world

```latex
\documentclass{jlreq}
\begin{document}
こんにちは世界
\end{document}
```

### 数式内での太字

`amsmath,amssymb`にある`\boldsymbol`を使う。ギリシャ文字や∇も太字になる。

```latex
\documentclass{jlreq}
\usepackage{amsmath,amssymb}
\begin{document}
$\boldsymbol{B}=\boldsymbol{\nabla}\times\boldsymbol{A}$

$ H=-i \boldsymbol{\alpha}\cdot \boldsymbol{\nabla}+m\beta$
\end{document}
```

出力はこんな感じ

$\boldsymbol{B}=\boldsymbol{\nabla}\times\boldsymbol{A}$

$ H=-i \boldsymbol{\alpha}\cdot \boldsymbol{\nabla}+m\beta$

### 黒板太字

#### なぜ黒板太字か

実は黒板太字を手書きだけでなく印刷物で使いたいと思う強い理由がある。

1. 学部の力学や電磁気では、ベクトル量とスカラー量を区別することは非常に重要である。多くの学生はこの区別で躓く。
2. 大学の物理ではベクトル量を表すのに太字を用いる。高校の数学では上に矢印を付ける記号を用いていて、こちらの方が教育上良いと思う。しかし、大学の物理の教科書では太字が広まってしまっていて、これは今更変えられない。勝手に変えるとかえってややこしくなる。
3. 例えば学生の立場にたってみて、教科書などの印刷物を見て演習問題を解いたり自分の手書きのノートを作るところを想像してみてほしい。印刷物に普通の太字で書いてあるものを、自分のノートに写すときにちゃんと黒板太字で写すだろうか？何も知らなければ100%普通の文字で写すだろう。
4. 問題点は、太字と細字は「異なる記号」というには同じすぎるのである。普通の本で太字で書いてあったら、それは単に強調されていると思うだろう。例えば、小説の中で「$A$さん」とという人と「$\boldsymbol{A}$さん」という人が違う人だったら、どう思うだろうか。
5. もちろん、授業では黒板には黒板太字で書き、区別するように強調する。優秀な学生なら、それで区別できるようになる。しかし、標準的な学生の場合は、それが身につくには時間がかかるし、演習問題をやるときになってあらためてノートを見返して、太字で書いてあったり細字で書いてあったりするのが何を意味するのかすぐに思い出せず、とりあえずめんどくさいから全部細字で書いておこう、ということになったりする。これはすべて学生が悪いとはいえない。記号がわかりにくすぎるのである。
6. そういう状況を少しでもよくするために私はプリントを作るときにも黒板太字を使っている。細字と太字の差よりも、細字と黒板太字の差の方がずっと大きいので「違うもの」と認識しやすいと信じている。小説の中で「$A$さん」と「$\mathbb{A}$さん」が違う人というほうが、少しはましだと思うが……。


#### 大文字のみ

大文字のみの場合は`amssymb`の中に入っている`\mathbb`が使える。

```latex
\documentclass{jlreq}

\usepackage{amsmath,amssymb}
\begin{document}
$z \in \mathbb{C}$
\end{document}
```

こんな感じで出力される。
$z \in \mathbb{C}$

#### 大文字、小文字、数字まで

いろいろなパッケージがあるが、私はいつも`newtxmath`を使ってるので、それについている`\vvmathbb`を用いている。

```latex
\documentclass{jlreq}

\usepackage{amsmath,amssymb}
\usepackage[varg]{newtxmath}

\begin{document}
$\mathbb{L}=\vvmathbb{r}\times \vvmathbb{p}$

$\vvmathbb{1}\in G$
\end{document}
```


#### ∇、ギリシャ文字

∇やギリシャ文字の黒板太字は一部を除いてユニコードすら振られていないようだ。
ギリシャ文字はともかく、∇は電磁気や力学の授業でも必ず使う。以前は自作していたが、Δをひっくり返せば得られる。ギリシャ文字は相対論的量子力学でDirac行列のαで用いたり、速度を光速で割ったものをβで表すときに用いる。

```latex
\documentclass{jlreq}

\usepackage{amsmath,amssymb}
\usepackage[varg]{newtxmath}

%%% 回転のために必要
\usepackage{graphicx}

%%% mathbbolと諸々の調整
\usepackage[bbgreekl]{mathbbol}
\DeclareSymbolFontAlphabet{\mathbb}{AMSb}
\DeclareSymbolFontAlphabet{\mathbbol}{bbold}
\DeclareMathSymbol{\bbepsilon}{\mathord}{bbold}{"0F}
\newcommand{\bbnabla}{\kern -.0em\raise 1.4ex\hbox{\rotatebox{180}{$\mathbbol{\Delta}$}}}
%%% ここまで

\begin{document}
$\mathbb{ABC}\mathbbol{ABCabc}\vvmathbb{ABCabc}\bbalpha \bbbeta \bbgamma$

$\mathbb{L}=\vvmathbb{r}\times \vvmathbb{p}$

$\bbbeta := \vvmathbb{v}/c$ 

$H=-i\bbalpha\cdot\bbnabla +m\beta$

$\mathbb{B}=\bbnabla\times \mathbb{A}$
\end{document}
```

### 数式番号を好きな記号にする

`\tag`を用いる。

```latex
\documentclass{jlreq}
\usepackage{amsmath}
\begin{document}
\begin{align}
m\ddot{x}=F
\tag{☆}
\label{eom}
\end{align}

運動方程式\eqref{eom}を用いる。
\end{document}
```


### 数式番号に節を入れる

### 参照してない式に数式番号を付けない

### マクロの後のスペース


<script type="text/x-mathjax-config">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['$','$']]}});
</script>
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>