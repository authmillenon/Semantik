Aufgabe 1

λx.t ⇒_α λy.$^x_y t     t=λa.y

mit y \in Var(t):
    λx.λa.y == λxa.y
    λy.$^x_y t == 
... abgewischt

[[λx.λy.x+y]]ρ = d ↦ [[λy.x+y]]ρ[d/x]
               = d ↦ e ↦ [[x+y]]ρ[d/x][e/y]
               = d ↦ e ↦ d+e

!=

[[λx.λy.y+y]]ρ = d ↦ [[λy.y+y]]ρ[d/x]
               = d ↦ e ↦ [[y+y]]ρ[d/x][e/x] = d ↦ e ↦ e+e

Aufgabe 2
(λx.t)s ⇒_β $^x_s t'        falls Fr(s) \cap Geb(t) \in ∅
(λx.λy.x)y

1) [[(λx.λy.x)y]]ρ = ([[λx.λy.x]]ρ)([[y]])
= (d_1 ↦ (d_2 ↦ d_1))(ρ(y)) = d_2 ⇒ ρ(y)
2) [[λy.y]]ρ = d ↦ d

Aufgabe 3
ungetypt
    (λx.xxx)(λx.xxx)
    (λx.xxx)(λx.xxx)(λx.xxx)

getypt
F = λrx.x+rx
    fix F y ⇒_δ F(fix F)y
  = (λrx.x+rx)(fix F)y
  = y + fix F y

  (Ausnahme)
oder
    t = (λx.f(xx))λx.f(xx)
    t ⇒_β f((λx.f(xx))λx.δ(xx)) = ft ⇒_β f(f(t)) ⇒^*_β f^n t

Aufgabe 4
a) λfx.f(f(f(x))) [D ⇒ D] ⇒ D ⇒ D
b) λLg.<g(π_1L);g(π_2L);g(π_3L);g(π_4L)>
c) (uncurry f) <a, b> = f a b
   (λfC.(f(π_1C))(π_2 C))

