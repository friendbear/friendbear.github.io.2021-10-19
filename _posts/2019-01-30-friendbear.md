---
layout: post
author: friendbear
title:  Scala (Inheritane, Variance, TypeMember)
categories: [blog, lang-scala]
tags: [lang-scala]
---

### Try Scala
- RockScalaForAdvanced
  - Advanced Inheritance

    ```scala
      Type linearization
      Cold = AnyRef with <Cold>
      Green
        = Cold with <Green>
        = AnyRef with <Cold> with <Green>
      Blue
        = Cold with <Blue>
        = AnyRef with <Cold> with <Blue> with <Green>
      Red = AnyRef with <Red>
    ```
  - Variance
    - Big rule
      - method arguments are in CONTRAVARIANT position
      - return types are in COVARIANT position
  - Type Member
    - Type Members
 
     ```scala
     class Animal
     class Dog extends Animal
     class Cat extends Animal

     class AnimalCollection {
       type AnimalType // abstract type member
       type BoundedAnimal <: Animal
       type SuperBoundedAnimal >: Dog <: Animal
       type AnimalC = Cat
     }

     trait MList {
       type A
       head: A
       def tail: MList
     }

     trait ApplicableToNumbers {
       type A <: Number
     }
     // NOT-OK
     class CustomList(hd: String, tl: CustomList) extends MList with ApplicableToNumbers   {
       type A = String
       def head = hd
       def tail = tl
     }

     // OK
     class IntList(hd: Int, tl: IntList) extends MList {
       type A = Int
       def head = hd
       def tail = tl
     }
     ```

### kumasora

### Reference
[GitHub PR protected branches](https://help.github.com/articles/configuring-protected-branches/)
### Usefull Link


### Recommend


### Snippets

<details>
<summary><code>RockingInheritance</code></summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def RockingInheritance(args: String*) = {

  // convenience
  trait Writer[T] {
    def write(value: T): Unit
  }
  trait Closeable{
    def close(status: Int): Unit
  }
  trait GenericsStream[T] {
    def foreach(f: T => Unit): Unit
  }
  def processStream[T](stream: GenericsStream[T] with Writer[T] with Closeable): Unit = {
    stream.foreach(println)
    stream.close(0)
  }

  // diamond problem
  trait Animal { def name: String }
  trait Lion extends Animal {
    override def name: String = "lion"}
  trait Tiger extends Animal {
    override def name: String = "tiger" }
  class Mutant extends Lion with Tiger

  val m = new Mutant
  println(m.name) // => "tiger"

  /*
    Mutant
    extends Animal with {override def name: String = "lion" }
    with {override def name: String = "tiger}

    LAST OVERRIDE GETS PICKED 🔴
   */

  // the super problem + type linearization
  trait Cold {
    def print = println("cold")
  }
  trait Green extends Cold {
    override def print: Unit = {
      println("green")
      super.print
    }
  }
  trait Blue extends Cold {
    override def print: Unit = {
      println("blue")
      super.print
    }
  }
  class Red {
    def print = println("red")
  }

  class White extends Red with Cold with Green with Blue {
    override def print: Unit = {
      println("write")
      super.print
    }
  }

  println(new White().print) // write => blue => green => cold //
}
</code>
</pre>
</details>

<details>
<summary><code>Variance</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def Variance(args: String*) = {

  trait Animal
  class Dog extends Animal
  class Cat extends Animal
  class Crocodile extends Animal

  // what is variance?
  // "inheritance" - type substitution of generics

  class Cage[T]
  // yes - covariance
  class CCage[+T]
  val ccage: CCage[Animal] = new CCage[Cat]

  // no - invariance
  class ICage[T]
  // val icage: ICage[Animal] = new ICage[Cat]
  // val x: Int = "Hello"

  //hell no -opposite = contravariance
  class XCage[-T]
  val xcage: XCage[Cat] = new XCage[Animal]

  class InvariantCage[T](val animal: T) // invariant

  // covariant position
  class CovariantCage[+T](val animal: T) // COVARIANT POSITION

  // class ContravariantCage[-T](val animal: T) 🔴
  /*
    val catCage: XCage[Cat] = new XCage[Animal](new Crocodile)
   */
  // class CovariantVariableCage[+T](var animal: T) 🔴
  /*
    val ccage: CCage[Animal] = new CCage[Cat](new Cat)
    ccage.animal = Crocodile
   */
  //class ContravariantVariableCage[-T](var animal: T) // also in COVARIANT POSITION
  // val catCage: XCage[Cat] = new XCage[Animal](new Crocodile)
  class InvariantVariableCage[T](var animal: T) // ok
  //trait AnotherCovariantCage[+T] {
  //  def addAnimal(animal: T) // CONTRAVARIANT POSITION
  //}
  /*
    val ccage: CCage[Animal] = new CCage[Dog]
    ccage.add(new Cat)
   */
  class AnotherContravariantCage[-T] {
    def addAnimal(animal: T) = true
  }
  val acc: AnotherContravariantCage[Cat] = new AnotherContravariantCage[Animal]
  acc.addAnimal(new Cat)
  class Kitty extends Cat
  acc.addAnimal(new Kitty)

  class MyList[+A] {
    def add[B >: A](element: B): MyList[B] = new MyList[B] // widening the type
  }

  val emptyList = new MyList[Kitty]
  val animals = emptyList.add(new Kitty)
  val moreAnimals = animals.add(new Cat)
  val evenMoreAnimals = moreAnimals.add(new Dog)

  // METHOD ARGUMENTS ARE IN CONTRAVARIANT POSITION.

  // return types
  class PetShop[-T] {
    // def get(isItaPuppy: Boolean): T // METHOD RETURN TYPES ARE IN COVARIANT POSITION
    /*
      val catShop = new PetShop[Animal] {
        def get(isItaPuppy: Boolean): Animal = new Cat
      }
     */
    /*
      val dogShop: PetShop[Dog] = catShop
      dogShop.get(true) // EVIL CAT!
    */
    def get[S <: T](isItaPuppy: Boolean, defaultAnimal: S): S = defaultAnimal
  }

  val shop: PetShop[Dog] = new PetShop[Animal]
  // val evilCat = shop.get(true, new Cat)
  val evilDog = shop.get(true, new Dog)

  class TerraNova extends Dog
  val bigFurry = shop.get(true, new TerraNova)

  /*
    Big rule
    - method arguments are in CONTRAVARIANT position
    - return types are in COVARIANT position
   */
}

</code>
</pre>
</details>
<details>
<summary><code>Type Members</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def TypeMembers(args: String*) = {

  class Animal
  class Dog extends Animal
  class Cat extends Animal

  class AnimalCollection {
    type AnimalType // abstract type member
    type BoundedAnimal <: Animal
    type SuperBoundedAnimal >: Dog <: Animal
    type AnimalC = Cat
  }

  val ac = new AnimalCollection
  val dog: ac.AnimalType = ???

  // val cat: ac.BoundedAnimal = new Cat //compile error

  val pup: ac.SuperBoundedAnimal = new Dog
  val cat: ac.AnimalC = new Cat

  type CatAlias = Cat
  val anotherCat: CatAlias = new Cat

  // alternative to generics
  trait MyList {
    type T
    def add(element: T): MyList
  }

  class NonEmptyList(value: Int) extends MyList {
    override type T = Int // override
    def add(element: Int): MyList = ???
  }

  // .type
  type CatsType = cat.type
  val newCat: CatsType = cat
  // new CatsType // Abstract Members(Type member)

  /*
    Exercise - enforce a type to be applicable to SOME TYPES only
   */
  // LOCKED
  trait MList {
    type A
    def head: A
    def tail: MList
  }

  // Number
  // type members and type member constraints(bounds) 🔴
  trait ApplicableToNumbers {
    type A <: Number
  }
  // NOT-OK
  /*
  class CustomList(hd: String, tl: CustomList) extends MList with ApplicableToNumbers {
    type A = String
    def head = hd
    def tail = tl
  }
  */

  // OK
  class IntList(hd: Int, tl: IntList) extends MList {
    type A = Int
    def head = hd
    def tail = tl
  }
}
</code>
</pre>
</details>
<details>
<summary>-</summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def ImplicitOrdering(args: String*) = {
}

</code>
</pre>
</details>

