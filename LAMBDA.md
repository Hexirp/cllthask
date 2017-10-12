# cll lambda caluclus

線形理論を表すラムダ計算を定義することを目指す。

## 構文

最初はすべてのシークエント計算の規則を書き出してみる。

    id: (- A -)
    cut: G0 :> f :> S0 -( A )- G1 :> g :> S1
    weakL: G :> _ f :> S
    weakR: G :> f _ :> S
    contrL: G :> # f :> S
    contrL: G :> f # :> S
    tL: G :> * f :> S
    tR: G0 :> f :> S0 -* A *- G1 :> g :> S1
    1L: G :> ^ f :> S
    1R: ^^
    wL1: G :> _& f :> S
    wL1: G :> &_ f :> S
    wR: G :> f -& A &- :> S
    pL: G :> f -| A |- :> S
    pR1: G :> f _| :> S
    pR2: G :> f |_ :> S
    oL: G0 :> f :> S0 -+ A +- G1 :> g :? S1
    oR: G :? f + :> S
    !L: G :> ! f :> S
    !R: G :> f ! :> S
    ?L: G :> 
