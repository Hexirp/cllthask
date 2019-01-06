# cllthask

線形論理を基礎としたプログラミング言語。

## 設計

関数の結合を中心に据える。連鎖型プログラミング言語と似たようなものだと思えば
良い（型検査は厳密に行われるが）。

```text
function_1
function_2
function_3
```

このような式は、Haskell で書くと `function_3 . function_2 . function_1` という
風になる。

```tex
function_1
, function_1_a_1
, function_1_b_1
  function_1_b_2
function_2
,
 function_2_a_1
,
 function_2_b_1
 function_2_b_2
```

関数を取って関数を返す高階関数の書き方については二種類考えていて、上の式は
Haskell で `function_2 function_2_a_1 (function_2_b_2 . function_2_b_1) .
function_1 function_1_a_1 (function_1_b_2 . function_1_b_1)` となる。両方とも
許される形で行こうかと思っている。

## 参考文献

線形論理そのものについて。

* [線形論理 - Wikipedia](https://ja.wikipedia.org/wiki/%E7%B7%9A%E5%BD%A2%E8%AB%96%E7%90%86)
* [Linear logic - Wikipedia](https://en.wikipedia.org/wiki/Linear_logic)

プログラミングへの応用。

* [haskell/linear-type.md at master · lotz84/haskell](https://github.com/lotz84/haskell/blob/76b0e39efc0a001c0618c5001f39105d0ae48c29/docs/linear-type.md) - Haskell での線形型について。
* [ATSプログラミング入門](http://jats-ug.metasepi.org/doc/ATS2/INT2PROGINATS/book1.html) - 実際に観 (view) という線形論理の値のように複製・削除できない値を持ち、それをメモリに関する操作を安全に行うために使うプログラミング言語。
