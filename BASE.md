# classic linear types caluclus

線形論理を表す計算を定義することを目指す。

## 単純化

線形論理のシークエント計算を基本とするが、そのままでは場合が多すぎるため、ある程度単純化する。両辺に一つの型、つまり`A |- B`の形しか扱わない。

この単純化は`*-autonomous category`により正当化される。

## 構文

forthと同じように関数を連鎖させる。

```
cllthask:

f
g
h

haskell:

h . g . f
```

高階関数の引数はこのように表す。

```
cllthask:

f
,
 f1
,
 f2
 f3
g
, g1
  g2
h

haskell:

h . g (g2 . g1) . f f1 (f3 . f2)
```
