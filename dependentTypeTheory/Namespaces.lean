-- Group related definitions, theorems, constants, etc.

namespace MyNamespace
  def a : Nat := 5
  def f (x: Nat) : Nat := x + 7
  def fa : Nat := f a -- f(x)
  #eval fa
end MyNamespace

#eval MyNamespace.fa

-- list is an in built namespace in Lean
#check List.nil
#check List.cons
#check List.map

open List

#check nil
#check cons
#check map

namespace Foo
  def a : Nat := 5
  def f (x : Nat) : Nat := x + 7

  def fa : Nat := f a

  namespace Bar
    def ffa : Nat := f (f a)
    #check fa
    #check ffa
  end Bar

  #check fa
  #check Bar.ffa
end Foo

#check Foo.fa
#check Foo.Bar.ffa

open Foo

#check fa
#check Bar.ffa

--namespaces can be reopened again after they are closed


namespace Foo
  def ffa : Nat := f (f a)
end Foo
