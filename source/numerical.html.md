---
layout: flat
title: 数値計算やってみました
lead:  
pageid: numerical
---
## 動機

私のふだんの研究では、あまり数値計算をするということがなく、ほとんどが手でやれることをやっている。それはそれで良いのだが、いざ手でできないということがあったとき、軽い気持ちで数値計算をやってみようということにならないような気がしている。こういうところに壁があるのは良くないので、この壁をとっぱらうため手でも解けるような簡単な問題を数値計算してみた。もちろん新しいことをやっているわけではないのだが、実際自分でコードを書いて、それが正しく動くと感動するものである。

それとは別に、mathjaxというwebpageに数式を表示するものがあるのだが、それのテストでもある。

## Young図の統計力学

以前にBPS状態の数え上げをやっていたときに出てきた、もっと簡単な模型。様々な文脈から研究されている。分配関数は
$$
Z=\sum_{\mathrm{Young図:} Y}e^{-\beta |Y|}
$$
と表される。これは実際足し上げを計算することができて
$$
Z=\frac{1}{\prod_{n=1}^{\infty} (1-e^{-\beta n})}
$$
となる。つまり手で完全に解けるわけだが、練習のためにこれを数値計算でやってみた。
ここでは、モンテカルロ法を使う。これは、Young図を確率$e^{-\beta|Y|}/Z$で次々に生成していき、その生成したYoung図でいろんな量の平均をとる。このYoung図の生成をどうやるかという部分について、いろいろな方法が考案されている。私がやってみたのはメトロポリス法というものである。
下の動画では、何もないYoung図から始めて、次々とYoung図を生成している。もともと赤い角があったものからYoung図が抜けたという図示の仕方をしている。Young図の統計力学の系は別名「結晶融解模型」とも呼ばれるが、この動画はその雰囲気を醸し出していると思う。
<iframe width="420" height="315" src="//www.youtube.com/embed/2XaY_hatrF4?rel=0" frameborder="0" allowfullscreen></iframe>

## 行列模型

行列模型は弦理論をはじめとして様々な場面に現れる。実際私も行列模型を用いた論文をいくつか書いている。私のやっているような行列模型は手で解けるものばかりではあるが、今回練習のために数値計算でどれくらいのものが出るかをやってみた。また、今回 [Julia](https://julialang.org/)という速くて書きやすい言語があることを知ったので、その練習も兼ねている。

最も簡単な行列模型はガウス型行列模型である。ガウス型行列模型の分配関数は$M$を$N\times N$
のエルミート行列として
$$
Z=\int dM \exp(-N \mathrm{Tr} M^2)
$$
と表される。この固有値分布が$N\to\infty$の極限で半円則を満たすことが知られている。この固有値分布を数値的に求めてみた。

まずは、Juliaの関数でガウス分布の乱数を発生させるものがあるのでそれを使ってエルミート行列を成分ごとにガウス分布にしたがって発生させる。さらにJuliaには行列の固有値を求める関数があるのでそれを使う。そうして固有値の分布をプロットしたのが下の図である。

![Gaussian](out.svg)

非常にきれいに半円則を見ることが出来る。

別の方法も試してみた。まず、対称性$M\to UMU^{-1}$, ($U$はユニタリー行列)を使って
$M$を対角化する。そうすると分配関数は固有値の積分に書ける。対角化するときのJacobianを考えると積分は
$$
Z=\int \prod_{i=1}^{N}
d\lambda_{i}
\prod_{i \lt j}
(\lambda_i-
\lambda_j)^2
\exp(-N \sum_{i=1}^{N} \lambda_i^2)
$$
この積分をモンテカルロ法でやると考えて、固有値の配位をメトロポリス法で生成したもののプロットが下の図である。

![Gaussian](out1.svg)

なんとか半円則になっているような気がする。計算時間としては、上のjuliaのライブラリを使ったものより長くかかっている。結局のところJuliaのガウス分布の乱数の生成が非常に素晴らしく、しかも速く固有値を求める関数があるのが効いている。それに比べて私の書いたモンテカルロ法の部分がへぼいのがこの差になったといえよう。

さて、ガウス型行列模型を少し変形したChern-Simons型行列模型というものがある。これは最近研究で使ったので馴染みになった。分配関数は、
$$
Z=\int \prod_{i=1}^{N}
d\lambda_{i}
\prod_{i\lt j}
\sinh^2 \frac 12(\lambda_i-
\lambda_j)
\exp(-\frac{1}{\beta} \sum_{i=1}^{N} \lambda_i^2)
$$
と定義される。この模型で$N\to \infty$の極限をとると、原点を中心とする、ある範囲で定数の固有値密度、それ以外の部分では固有値密度が0となる。これをやはりモンテカルロ法で計算してみると下のようになる。

![CS](out2.svg)

それほど良くはないものの解析的に得られた結果を再現することができた。

## 2018年5月1日追記

時は流れ、juliaも進化しいろいろ便利になった。jupyter notebook とかを使って

```julia
using Plots
gr()
using LinearAlgebra #v1.0から必要
N=3000
a=randn(N,N)
h=Hermitian(a+a'+im*(a-a'))
eigenvalues=eigvals!(h)/sqrt(4N)
histogram(eigenvalues,bin=40, normed=true)
plot!(x -> sqrt(4-x^2)/(2π), -2, 2, linewidth=2)
```

とやると（結構時間はかかるかもしれないが）以下のような半円の分布の絵が描ける。

![半円](semi-circle.svg)

ヒストグラムが、3000×3000の一個の行列をガウス分布で生成し、その固有値の分布をある正規化でヒストグラムを描いたもの。赤い線が理論的に計算される半円分布。非常によく合っていることが分かる。

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['$','$']]}});
</script>
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML">
</script>

## 2025年4月追記

Google Colab でjuliaが使えるようになっている。GPUも使える。試しに[[2503.23921] K-theoretic computation of the Atiyah(-Patodi)-Singer index of lattice Dirac operators](https://arxiv.org/abs/2503.23921)の計算のコードを動かしてみたら動いた。しかもGPUが使えるので、かなり速い。

### コードへのリンク

- [整数に値をとる指数](https://colab.research.google.com/drive/1v-e-ng0D_87OyBc5Vk5xwmJJvWeaoxsJ?usp=sharing)
- [Mod 2 指数](https://colab.research.google.com/drive/18WipBgDPhFNYdmWB-kSbiTgIUtQ5BcP2?usp=sharing)

### 動かし方

Googleのアカウントがあれば、誰でも実行してみることができるはず。以下のようにする。

- Googleにログインしておく。
- 上のリンクのどちらかに飛ぶ。
- メニューの ファイル＞ドライブにコピーを保存 を選ぶ。
- コピーの方で上から実行（各セルの左にある▷を押す）していく。Main Codeのところは実行するとエラーが出るかもしれないが、その場合はもう一度実行する。
