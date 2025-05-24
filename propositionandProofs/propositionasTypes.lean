-- 1. Proof p ≡ p
-- "We can avoid writing the term Proof repeatedly by conflating Proof p with p itself."
-- Instead of wrapping everything in Proof, Lean just uses the type p directly. So:

-- Writing t : p means "t is a proof of p".


-- 2. Implication is just a function type
-- "...we can pass back and forth between Implies p q and p → q."
-- Lean doesn’t need a special Implies constructor — because implication is just a function:

-- A proof of p → q is literally a function that takes a proof of p and returns a proof of q.

-- 3. Prop is Sort 0
-- "Prop is syntactic sugar for Sort 0..."

-- Lean has a hierarchy of universes:

-- Prop ≡ Sort 0

-- Type u ≡ Sort (u + 1)

-- The type of all propositions is the lowest universe Sort 0, and propositions live here.

-- 5. Proof irrelevance
-- "Lean's kernel treats any two elements t₁ t₂ : p as definitionally equal..."

-- This means: if p : Prop, then any two proofs of p are indistinguishable — they are treated as equal.


-- To prove p : Prop, just construct t : p.

-- Lean verifies that t is well-typed, i.e., a valid proof.

-- You don't write:


Proof (p → q)
-- Instead, you just write:
p → q
-- And if you want to prove it, you construct a function:
def mp (p q : Prop) (h₁ : p → q) (h₂ : p) : q := h₁ h₂
-- That is a proof of proposition q
-- if h1 is proof of validity of p-> q
-- and h2 is proof of validity of p
-- then q can be proved

-- if p is true and q is true then p is true
-- p -> q -> p

variable {p q : Prop}
theorem t1: p->q->p :=
  fun hp : p => fun hq : q => hp
#print t1
-- Propositions treated as types , prrofs treated as terms

--same as
def projLeft (x : α) (y : β) : α :=
  x

variable {p : Prop}
variable {q : Prop}
theorem t12 : p → q → p :=
  fun hp : p =>
  fun hq : q =>
  show p from hp

--same as
theorem t2 (hp : p) (hq : q) : p :=
  hp
-- this theorm says if proof of p and q exists then proof of p exists

--the below exiom states trust that p is true
axiom hp:p
axiom hq:q
theorem t3 : q->p :=
  t2 hp
-- we know if p is true and q is true then p is true by t2, also by axiom p is true  therfore if q is true then p is true

-- above is a disasterous method
-- axiom assumes propsition is true without proving it
-- theorem1 same as
theorem t11 : ∀ {p q : Prop}, p → q → p :=
  fun {p q : Prop} (hp : p) (hq : q) => hp

--same as
theorem t21 : p → q → p :=
  fun (hp : p) (hq : q) => hp
--since p and q have already been declared as propositions

theorem t22 (p q : Prop) (hp : p) (hq : q) : p := hp
variable (p q r s : Prop)

#check t22 p q
-- #check t2 p q # doesn't work because it needs proof as inputs and not propositions
#check t22 (r->s) (s->r)
variable (h:r->s) --h is proof of r->s
variable (g: s->r)
#check t22 (r->s) (s->r) h g -- p q and hp given
#check t22 (r->s) (s->r) h  -- p q and hp given

theorem t4 (h₁ : q → r) (h₂ : p → q) : p → r :=
  fun h₃ : p =>
  show r from h₁ (h₂ h₃) --prove r by applying h1 to the result of applying h2 to h3

--same as

theorem t41 (h₁ : q → r) (h₂ : p → q) : p → r :=
  fun h₃ : p =>
    h₁ (h₂ h₃)


--same as

variable (A B C : Type)

def compose (f : B → C) (g : A → B) : A → C :=
  fun x : A => f (g x)


 --Curry-Howard Isomophism
-- Proofs are programs, and propositions are types.
variable (p : Prop)
#check p
