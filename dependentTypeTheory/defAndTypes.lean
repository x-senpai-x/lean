def m : Nat :=
  1
def n: Nat :=
  8
def b: Bool :=
  true
def b1: Bool :=
  false

#check b
#check m

#eval n
#eval 3+4*3-12
--#eval 5*b  operation on different types gives error
#eval b||b1

#check Nat → Nat --Nat → Nat : Type
#check Nat → Nat → Nat --Nat → Nat -> : Type
#check Nat → (Nat → Nat) --Nat → Nat -> : Type
#check (Nat → Nat) → Nat --Nat → Nat -> : Type
--cartesian product
#check Prod --Prod.{u, v} (α : Type u) (β : Type v) : Type (max u v)
#check Nat × Nat --Type

#check (0,1) --(0, 1) : Nat × Nat
#check Nat.add -- Nat.add is a function that takes 2 arguments and returns the 3rd i.e Nat->Nat->Nat
#check Nat.succ -- ⊢ Nat → Nat
#check Nat.mul

#eval Nat.add 4 3
#eval Nat.succ 4
#eval (4,3).1

#check (m,n)


-- definined contants for types
def α : Type :=
  Nat
def β : Type :=
  Bool

#check List -- List.{u} (α : Type u) : Type u
-- list represents a sequence of elements of the same type
-- A list of type α (written as list α) is either:
#check List α -- Type  ; alpha is a type
#check α -- Type
-- The below gives error because List in itself is Type->Type
-- def F : Type :=
--   List
def F : Type :=
  List α -- Type
def G : Type -> Type :=
  List -- Type -> Type
def H : Type-> Type ->Type :=
  Prod -- Type -> Type -> Type
#check Prod
#check Prod α β  -- α × β : Type
#check List α -- Type
#check List β -- Type
#check G α -- Type
#check G  -- Type → Type
#check H α β -- Type
#check H α  -- Type → Type
#check H Nat Nat -- Type
#check Prod Nat Nat -- Type

#check Type -- Type.{u} : Type.{u+1}
#check Type 32
-- #check Type 33 32 is the maximum level of type
-- Think of Type 0 as a universe of "small" or "ordinary" types. Type 1 is then a larger universe of types, which contains Type 0 as an element, and Type 2 is an even larger universe of types, which contains Type 1 as an element. The list is infinite: there is a Type n for every natural number n.

#check Type->Type -- Type -> Type : Type1
#check Type -- Type1
#check Type 1
#check Type 1 -> Type

--  Polymorphic Constants
-- A polymorphic constant is a constant (function, type, theorem, etc.) that is generic over a type. Instead of being defined for a specific type like ℕ or bool, it's defined for any type α.
def id1 {α : Type} (x : α) : α :=
  x
#eval id1 5
#eval id1 true
#eval id1 (5, 6+1)

-- Type u is the type of types in universe u

universe u
def my_id (α : Type u) (x : α) : α :=
x
-- This defines my_id for any type α in any universe u. If you don’t specify the universe, Lean may assign Type 0 or generalize automatically.
-- This tells for any type say α that is input to the function my_id it will return the same type α

universe v
def const {α β : Type v} (x:α)(y:β) : α :=
  x
#eval const 5 true
#eval const 5 6
#eval const 5 (6, 7) 
