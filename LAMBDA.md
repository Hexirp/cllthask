# cll lambda caluclus

線形理論を表すラムダ計算を定義することを目指す。

## 構文

最初はすべてのシークエント計算の規則を書き出してみる。

```
id: (- A -)
cut: G0 :> f :> S0 -( A )- G1 :> g :> S1
weakL: G :> _ f :> S
weakR: G :> f _ :> S
contrL: G :> # f :> S
contrL: G :> f # :> S
tL: G :> * f :> S
tR: G0 :> f :> S0 -* A *- G1 :> g :> S1
wL1: G :> _& f :> S
wL2: G :> &_ f :> S
wR: G :> f -& A &- :> S
pL: G :> f -| A |- :> S
pR1: G :> f _| :> S
pR2: G :> f |_ :> S
oL: G0 :> f :> S0 -+ A +- G1 :> g :? S1
oR: G :? f + :> S
!L: G :> ! f :> S
!R: G :> f ! :> S
?L: G :> f ? :> S
?R: G :> ? f :> S
1L: G :> ' f :> S
1R: ''
TR: G :> , :> S
0L: G :> . :> S
BL: ""
BR: G :> f " :> S
```

これらは実用的ではない。この構文の基礎は「線形論理は入力と出力が対称であるため、構文も対称なものでなければならない」ということである。連鎖型言語に似ているが、返り値が直積ではなく直和である。しかし、スタックという概念は有用であると思われる。

標準形式を`G0,G1,G2...,Gn |- S0,S1,S2...,Sn`とする。左右は型の列である。

```
id: []
cut: f g

weakL: [f] !_
weakR: [f] ?_
contrL: [f] !#
contrL: [f] ?#

tL: [f] *
tR: [[f...]]
wL1: [f] &_
wL2: [f] _&
wR: [{f...}]
pL: {[f...}]
pR1: [f] |_
pR2: [f] _|
oL: {{f...}}
oR: [f] +

!L: [f] !
!R: [f] !!
?L: [f] ??
?R: [f] ?

1L: [f] '
1R: [[]]
TR: [{}]
0L: {[]}
BL: {{}}
BR: [f] "
```
