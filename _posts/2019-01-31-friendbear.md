---
layout: post
author: friendbear
title:  Scala (Inner Types, Structural Types and Compile-Time Duck Typing, Self Types)
categories: [blog, lang-scala]
tags: [lang-scala]
---

### Try Scala
- RockScalaForAdvanced
  - Inner Types and Path-Dependent Type

    ```scala
    ```
  -  Structural Types and Compile-Time Duck Typing
  
    ```scala
      trait CBL[+T] {
        def head: T
        def tail: CBL[T]
      }

      class Human {
        def head: Brain = new Brain
      }
      class Brain {
        override def toString: String = "BRAINZ!"
      }

      def f[T](somethingWithAHead: {def head: T}): Unit = println(somethingWithAHead.head)

      /*
        f is compatible with a CBL and with a Human? yes.
       */

      case object CBNil extends CBL[Nothing] {
        def head: Nothing = ???
        def tail: CBL[Nothing] = ???
      }
      case class CBCons[T](override val head: T, override val tail: CBL[T]) extends CBL[T]

      f(CBCons(2, CBNil))
      f(new Human) // ?! T = Brain !!

      // 2.
      object HeadEqualizer {
        type Headable[T] = { def head: T }
        def ===[T](a: Headable[T], b: Headable[T]): Boolean = a.head == b.head
      }

      /*
        is compatible with a CBL and with a Human? Yes.
       */
      val brainzList = CBCons(new Brain, CBNil)
      val stringsList = CBCons("Brainz", CBNil)

      HeadEqualizer.==(brainzList, new Human)

      HeadEqualizer.==(new Human, stringsList) // not type safe
    ```
  - Self Types

    ```scala
      // vs inheritance
      class A
      class B extends A // B is an A

      trait T
      trait S {self: T => } // S REQUIRES a T
    ```

### kumasora

### Reference

### Usefull Link

### Recommend


### Snippets

<details>
<summary><code>PathDependentTypes</code></summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def PathDependentTypes(args: String*) = {
  class Outer {
    class Inner
    object InnerObject
    type InnerType

    def print(i: Inner) = println(i)
    def printGeneral(i: Outer#Inner) = println(i)
  }

  def aMethod: Int= {
    class HelperClass
    type HelperType = String
    2
  }

  // per-instance
  val o = new Outer
  val inner = new o.Inner // o.Inner is a Type

  val oo = new Outer
  // val otherInner: oo.Inner = new o.Inner

  o.print(inner)

  // path-dependent types

  // Outer#Inner
  o.printGeneral(inner)
  oo.printGeneral(inner)

  /*
    Exercise
    DB keyed by Int or String, but maybe others
   */
  /*
    use path-dependent types
    abstract type members and/or type aliases
   */
  trait ItemLike {
    type Key
  }
  trait Item[K] extends ItemLike {
    type Key = K
  }
  trait IntItem extends Item[Int]
  trait StringItem extends Item[String]

  def get[ItemType <: ItemLike](key: ItemType#Key): ItemType = ???

  get[IntItem](42) // ok

  get[StringItem]("scala") // ok
}
</code>
</pre>
</details>

<details>
<summary><code>StructuralTypes</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def StructuralTypes(args: String*) = {

  // structural types
  type JavaCloseable = java.io.Closeable
  class HipsterCloseable {
    def close() = println("yeah yeah I'm closing")
    def closeSilently(): Unit = println("not make sounds")
  }

  // def closeQuietly(closeable: JavaCloseable OR HipsterCloseable) // ?!
  type UnifiedCloseable = {
    def close(): Unit
  } // STRUCTURAL TYPE
  def closeQuietly(unifiedCloseable: UnifiedCloseable): Unit = unifiedCloseable.close()

  closeQuietly(new JavaCloseable {
    override def close(): Unit = ???
  })
  closeQuietly(new HipsterCloseable)


  // TYPE REFINEMENTS java Closeable + closeSilently
  type AdvancedCloseable = JavaCloseable {
    def closeSilently(): Unit
  }
  class AdvancedJavaCloseable extends JavaCloseable {
    override def close(): Unit = println("Java closes")
    def closeSilently(): Unit = println("Java closes silently") // 🔴
  }

  def closeShh(advCloseable: AdvancedCloseable): Unit = advCloseable.closeSilently()

  closeShh(new AdvancedJavaCloseable)
  // closeShh(new HipsterCloseable) => compile error

  // using structural types as standalone types
  // oun type
  def altClose(closeable: {def close(): Unit}): Unit = closeable.close()

  // type-checking => dock typing
  type SoundMaker = {
    def makeSound(): Unit
  }

  class Dog {
    def makeSound(): Unit = println("bark!")
  }
  class Car {
    def makeSound(): Unit = println("yroooom!")
  }

  // static duck typing
  val doc: SoundMaker = new Dog // runtime structure type use reflection
  val car: SoundMaker = new Car

  // CAVEAT: based on reflection

  /*
    Exercises
   */
  // 1.
  trait CBL[+T] {
    def head: T
    def tail: CBL[T]
  }

  class Human {
    def head: Brain = new Brain
  }
  class Brain {
    override def toString: String = "BRAINZ!"
  }

  def f[T](somethingWithAHead: {def head: T}): Unit = println(somethingWithAHead.head)

  /*
    f is compatible with a CBL and with a Human? yes.
   */

  case object CBNil extends CBL[Nothing] {
    def head: Nothing = ???
    def tail: CBL[Nothing] = ???
  }
  case class CBCons[T](override val head: T, override val tail: CBL[T]) extends CBL[T]

  f(CBCons(2, CBNil))
  f(new Human) // ?! T = Brain !!

  // 2.
  object HeadEqualizer {
    type Headable[T] = { def head: T }
    def ===[T](a: Headable[T], b: Headable[T]): Boolean = a.head == b.head
  }

  /*
    is compatible with a CBL and with a Human? Yes.
   */
  val brainzList = CBCons(new Brain, CBNil)
  val stringsList = CBCons("Brainz", CBNil)

  HeadEqualizer.==(brainzList, new Human)

  HeadEqualizer.==(new Human, stringsList) // not type safe
}

</code>
</pre>
</details>
<details>
<summary><code>Self Types</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def SelfTypes(args: String*) = {
  // requiring a type to be mixed in

  trait Instrumentalist {
    def play(): Unit
  }

  // SELF TYPE whoever implements Singer to implement Instrumentalist
  trait Singer { this: Instrumentalist =>

    // rest of the implementation or API
    def sing(): Unit
  }

  class LeadSinger extends Singer with Instrumentalist {
    override def play(): Unit = ???
    override def sing(): Unit = ???
  }

  val jamesHetfield = new Singer with Instrumentalist {
    override def play(): Unit = ???
    override def sing(): Unit = ???
  }

  class Guitarist extends Instrumentalist {
    override def play(): Unit = println("(guitar solo)")
  }

  val ericClapton = new Guitarist with Singer {
    override def sing(): Unit = ???
  }

  // vs inheritance
  class A
  class B extends A // B is an A

  trait T
  trait S {self: T => } // S REQUIRES a T

  // CAKE PATTERN => "dependency injection"

  // DI
  class Component {
    // API

  }
  class ComponentA extends Component
  class ComponentB extends Component
  class DependentComponent(val component: Component)

  // CAKE PATTERN
  trait ScalaComponent {
    // API
    def action(x: Int): String
  }
  trait ScalaDependentComponent { self: ScalaComponent =>
    def dependentAction(x: Int): String = action(x) + " this rocks!"
  }
  trait ScalaApplication { self: ScalaDependentComponent => }

  // layer 1 - small components
  trait Picture extends ScalaComponent
  trait Stats extends ScalaComponent

  // layer 2 - compose
  trait Profile extends ScalaDependentComponent with Picture
  trait Analytics extends ScalaDependentComponent with Stats

  // layer 3 - app
  trait AnalyticsApp extends ScalaApplication with Analytics

  // cyclical dependencies
  // class X extends Y
  // class Y extends X
  trait X { self: Y => }
  trait Y { self: X => }
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

