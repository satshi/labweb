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

`amsmath`にある`\boldsymbol`を使う。ギリシャ文字や∇も太字になる。

```latex
\documentclass{jlreq}
\usepackage{amsmath}
\begin{document}
$\boldsymbol{B}=\boldsymbol{\nabla}\times\boldsymbol{A}$

$ H=-i \boldsymbol{\alpha}\cdot \boldsymbol{\nabla}+m\beta$
\end{document}
```

出力はこんな感じ

$\boldsymbol{B}=\boldsymbol{\nabla}\times\boldsymbol{A}$

$ H=-i \boldsymbol{\alpha}\cdot \boldsymbol{\nabla}+m\beta$

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


