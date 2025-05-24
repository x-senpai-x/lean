-- Preferense order :
-- unary negation >> and >> or
variable (p q r: Prop)
#check p → q → p ∧ q
#check ¬p → q → p ∧ q -- wrong
#check p->(q->r) --if p then if q then r
--same as
#check p ∧ q ->r
--arrow → is right associative i.e parsed right to left
-- an expression like:
-- p → q → r
-- is parsed as
-- p → (q → r)

--example command states a theorem without naming it or storing it in the permanent context.
example (h: p ∧ q ) : p :=
  And.left h
-- And.left h creates a proof of p from a proof h : p ∧ q
example (h:p∧q ): q:=
  And.right h

example (hp: p)(hq: q) : p∧q :=
  And.intro hp hq --And.intro just means by definition this holds true
--And.intro proves that p -> q -> p^q

example (h:p∧q) :q∧p :=
  And.intro (And.right h) (And.left h)

-- we can often write ⟨hp, hq⟩ instead of And.intro hp hq:
variable (hp:p)(hq:q)
#check (⟨hp, hq⟩ : p ∧ q) -- these are angular brackets

variable (xs : List Nat)

#check List.length xs
--equivalent to
#check xs.length

-- As a result, given h : p ∧ q, we can write h.left for And.left h and h.right for And.right h.

example (h:p∧q): q ∧ p :=
  ⟨ h.right,h.left ⟩
  --and completely removed from the proof

--Or
example (hp:p) : p ∨  q :=
  Or.intro_left q hp
example (hq:q) : p ∨ q :=
  Or.intro_right p hq
example (hq:q) : q ∨ p :=
  Or.intro_left p hq
example (hp:p) : q ∨ p :=
  Or.intro_right q hp

--or.elim : we can prove r from p ∨ q, by showing that r follows from p and that r follows from q
-- i.e  In the expression Or.elim hpq hpr hqr, Or.elim takes three arguments, hpq : p ∨ q, hpr : p → r and hqr : q → r, and produces a proof of r

example (hpq: p ∨ q)(hpr: p→r)(hqr: q → r) : r :=
  Or.elim hpq hpr hqr

--proving commutativity of or

example (h : p ∨ q) : q ∨ p :=
  Or.elim h (fun hp:p => Or.intro_right q hp ) (fun hq:q => Or.intro_left p hq)
-- here r is q->p
-- p ∨ q -> (p → (q ∨ p)) -> (q → (q ∨ p))
-- In the Curry-Howard correspondence (or isomorphism), logical implication p → q is interpreted as a function type: a function that takes a proof of p and produces a proof of q.
-- Therefore fun hp : p => some_proof_of_q is equivalent to p → q

--Or.elim h can be replaced by h.elim

--Negation

--Negation, ¬p, is actually defined to be p → False, so we obtain ¬p by deriving a contradiction from p
-- the expression hnp hp produces a proof of False from hp : p and hnp : ¬p
example (hpq: p → q)(hnq: ¬q) : ¬p :=
  fun hp:p => hnq (hpq hp)
-- If p → q and ¬q, then ¬p.

--same as
example (hpq : p → q) (hnq : ¬q) : ¬p :=
  fun hp : p =>
  show False from hnq (hpq hp)
--The connective False has a single elimination rule, False.elim, which expresses the fact that anything follows from a contradiction. This rule is sometimes called ex falso

--Principle of explosion: If you assume a contradiction, anything can be concluded.
--False is a special proposition that has no proofs.
example (hp:p)(hnp: ¬p) : q :=
  False.elim (hnp hp)
-- hnp is a fn that takes proof of p and produces a contradiction
-- False.elim : False → q
-- given a proof of False any proposition q can be proven
-- q can't be achieved directly but if our assumptions contradict then Lean lets us jump to any conclusion


--Logical Equivalence iff
example (h: p→q)(g: q→p) : p↔q :=
  Iff.intro (h) (g)

theorem and_swap : p∧q ↔ q∧p := --we need h1: p^q -> q^p and h2: q^p -> p^q
  Iff.intro
    (fun h : p∧q => And.intro (And.right h) (And.left h))
    (fun h : q∧p => And.intro (And.right h) (And.left h))

--proving commutativity of and using and_swap
#check and_swap p q
example (h: p∧q) : q∧p :=
  Iff.mp (and_swap p q) h

--anonymous constructor back to action
theorem and_swap2 : p ∧ q ↔ q ∧ p :=
  ⟨ fun h => ⟨h.right,h.left⟩,fun h => ⟨h.right,h.left⟩ ⟩

example (h: p∧q) : q∧p :=
  (and_swap2 p q ).mp h

