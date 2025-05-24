variable (p q : Prop)
example (h:p∧q) :q∧p :=
  And.intro (And.right h) (And.left h)
--alternate way ellaborative

example (h:p∧q) :q∧p :=
  have hp: p :=
    h.left
  have hq: q :=
   h.right
  show q∧p from And.intro (hq) (hp)

--reasoning backwards from a goad
example (h:p∧q) :q∧p :=
  have hp: p :=
    h.left
  suffices hq:q from And.intro hq hp
  show q from And.right h

--Law of Excluded Middle (EM)
-- every proposition is either true or false.
-- A classical mathematician says: "Either the Riemann Hypothesis (RH) is true, or it's not."
-- A constructive mathematician can't assert this unless they can prove RH or ¬RH.

--opening the Classical namespace
open Classical

#check em p

--In classical logic, double negation can be removed:

theorem dne {p : Prop} (h : ¬¬p) : p :=
  Or.elim (em p)
    (show p→p from fun hp : p => hp)--if p is true return hp
    (show ¬p→p from fun hnp : ¬p => absurd hnp h)-- if ¬p is true return hnp

-- This doesn't work in constructive logic because ¬¬p does not imply p unless you use excluded middle.
