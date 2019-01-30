---
layout: post
author: friendbear
title:  Scala (Inner Types)
categories: [blog, lang-scala]
tags: [lang-scala]
---

### Try Scala
- RockScalaForAdvanced
  - Inner Types and Path-Dependent Type

    ```scala
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
<summary><code>Variance</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def Variance(args: String*) = {

}

</code>
</pre>
<details>
<summary><code>Type Members</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def TypeMembers(args: String*) = {
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

