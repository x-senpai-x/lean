#check fun (x: Nat) =>
  x + 2 -- Nat-> Nat
#check fun x =>
  x + 5 -- Nat automatically inferred
#check λ x =>
  x + 5 -- λ is a shorthand for fun
#eval (λ x : Nat => x+5) 10

#check fun x : Nat => fun y : Bool => if not y then x else x+1
-- first fun  calls second fun with arguments in sequence
#eval (fun x : Nat => fun y : Bool => if not y then x else x+1) 10 false

#check fun x y => if not y then x else x+1 -- same as above
#eval (fun x y => if not y then x else x+1) 10 false

def f (n: Nat): String :=
  toString n
#check f
#check f 5
#eval f 5  -- String

def g (s: String): Bool :=
  s.length > 0
#eval ( fun x=>g (f x) ) 123

def double (x: Nat): Nat :=
  x + x
def double2 : Nat -> Nat :=
  fun x=> x+x
def add (x y :Nat) :  Nat :=
  x+y
def add1 : Nat -> Nat -> Nat :=
  fun a b  => a+b
def islarger (x y : Nat): Bool :=
  if x>y then true
  else false
#eval islarger 5 10

#eval (fun x => (fun y => x + 2*y) 10 ) 15

--Composing functions

#check fun (g : String → Bool) (f : Nat → String) (x : Nat) => g (f x)
#check fun (g : String → Nat) (f : Nat → String) (x: String) => f (g x)

def compose (α β γ : Type) (f: α->β )(g: β->γ)(x: α): γ :=
  g (f x)
def callTwice (f: Nat->Nat)(x: Nat): Nat :=
  f (f x)
#eval callTwice double 5
#eval callTwice double 5
#eval compose Nat Nat Nat double double 5

variable (α β γ : Type)
variable (f: α->α)
def callTwice2 (x: α):=
  f (f x)
#eval callTwice2 Nat double 5
def boolToBool (x: Bool): Bool :=
  if x then true
  else false
#eval boolToBool true
#eval callTwice2 Bool boolToBool true

 --Section
-- A section lets you define a local scope for variables.
-- Variables declared inside a section are only visible within that section.

section useful
  variable (α β γ : Type)
  variable (g : β → γ) (f : α → β) (h : α → α)
  variable (x : α)

  def composeagain := g (f x)
  def doTwice := h (h x)
  def doThrice := h (h (h x))
end useful
