---
layout: post
author: friendbear
title: implicit class Pimp My Library
categories: [blog, lang-scala]
tags: [lang-scala]
---


### Try Scala
- RockScalaForAdvanced
  - Pimp My Library!
  - Scala & JVM Standard Parallel Libraries
    - implicit class RichInt(val value: Int) extends AnyVal


### kumasora

### Reference

### Usefull Link

### Recommend


### Snippets

<details>
<summary>PimpMyLibrary</summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def PimpMyLibrary(args: String*) = {
 /*
    Keep enriching the Int class
    - times(function)
      3.times(() => ...)
    - *
      * List(1,2) => List(1, 2, 1, 2, 1, 2)
  */
  implicit class RichInt(val value: Int) extends AnyVal {
    def isEven: Boolean = value % 2 == 0
    def sqrt: Double = Math.sqrt(value)

    def times(function: () => Unit) = {
      def timesAux(n: Int): Unit =
        if (n <= 0) ()
        else {
          function()
          timesAux(n - 1)
        }
      timesAux(value)
    }

    def *[T](list: List[T]): List[T] = {
      def concatenate(n: Int): List[T] =
        if (n <= 0) List()
        else concatenate(n - 1) ++ list
      concatenate(value)
    }
  }

  val test1 = {
    3.times(() => println("Scala Rocks!"))
    println(3 * List(1,2))
  }

  implicit class RicherInt(richInt: RichInt) {
    def isOdd: Boolean = richInt.value % 2 != 0
  }
  new RichInt(42).sqrt

  42.isEven // new RichInt(42).sqrt
  // type enrichment = pimping

  1 to 10

  import scala.concurrent.duration._
  3.second

  // 🔴 compiler does't do multiple implicit searchers.
  // 42.isOdd => Compile Error

  /*
    enrich the String class
    - asInt
    - encrypt
      "John" -> Lnip
   */
  implicit class RichString(s: String) {
    def asInt = Integer.valueOf(s) // java.lang.Integer -> Int
    def encrypt(cypherDistance: Int) = s.map(c => (c + cypherDistance).asInstanceOf[Char])
  }

  val test2 = {
    println("3".asInt)
    println("John".encrypt(2))
  }

  // "3"/4
  implicit def stringToInt(string: String): Int = Integer.valueOf(string)

  // equivalent: implicit class RichAltInt(value: Int)
  class RichAltInt(val value: Int)
  implicit def enrich(value :Int) = new RichAltInt(value)

  val test3 = {
    println("6" / 2)
    println(enrich(10).value)
  }

  // danger zone
  implicit def intToBoolean(i: Int): Boolean = i == 1
  /*
    if (n) do something
    else do something else
   */
  val test4 = {
    val aConditionedValue = if (3) "OK" else "Something wrong"
    println(aConditionedValue) // => "Something wrong" why?
  }
}
</code>
</pre>
</details>

<details>
<summary>AtomicReference</summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def AtomicReference(args: String*) = {
}
</code>
</pre>
</details>
<details>
<summary>ImplicitInto</summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def ImplicitInto(args: String*) = {
}
</code>
</pre>
</details>
<details>
<summary>ImplicitOrdering</summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def ImplicitOrdering(args: String*) = {
}

</code>
</pre>
</details>
<details>
<summary>TypeClass</summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def TypeClass(args: String*) = {

}
</code>
</pre>
</details>

