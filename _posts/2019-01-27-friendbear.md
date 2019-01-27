---
layout: post
author: friendbear
title: Scala(implicit class Pimp My Library, Type Class Part3)
categories: [blog, lang-scala]
tags: [lang-scala]
---


### Try Scala
- RockScalaForAdvanced
  - Pimp My Library!
  - 🔵 Type Class Part3
    - Very difficulty


```scala
  def htmlBoilerplate[T](content: T)(implicit serializer: HTMLSerializer[T]): String =
    s"<html><body> ${content.toHTML(serializer)} </body></html>"

  def htmlSugar[T : HTMLSerializer](content: T): String = {
     val serializer = implicitly[HTMLSerializer[T]]
     // use serializer
     s"<html><body> ${content.toHTML(serializer)}</body></html>"
   }

  // implicitly
  case class Permissions(mask: String)
  implicit val defaultPermissions: Permissions = Permissions("0744")

  // in some other part of the code
  val standardPerms = implicitly[Permissions](defaultPermissions)
```

* test code
```scala
    println(2.toHTML)
    println(john.toHTML(PartialUserSerializer))

    println(htmlBoilerplate(john)(HTMLSerializer[User]))
    println(htmlSugar(john))
```


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
def TypeCaseEqual(args: String*) = {
  /**
    * Equality
    */
  // TYPE CLASS
  trait Equal[T] {
    def apply(a: T, b: T): Boolean
  }
  object Equal {
    def apply[T](a: T, b: T)(implicit equalizer: Equal[T]): Boolean =
      equalizer.apply(a, b)
  }

  implicit object NameEquality extends Equal[User] {
    override def apply(a: User, b: User): Boolean = a.name == b.name
  }
  object FullEquality extends Equal[User] {
    override def apply(a: User, b: User): Boolean = a.name == b.name && a.email == b.email
  }

  /*
    Exercise - improve the Equal TC with an implicit conversion class
    ===(another value: T)
    !==(another value: T)
   */
  implicit class TypeSafeEqual[T](value :T) {
    def ===(another: T)(implicit equalizer: Equal[T]): Boolean = equalizer.apply(value, another)
    def !==(another: T)(implicit equalizer: Equal[T]): Boolean = ! equalizer.apply(value, another)
  }

  val john = User("Jon", 44, "jon@example.com")
  val anotherJohn = User("Jon", 44, "jon@example.com")

  println(john === anotherJohn)
}
</code>
</pre>
</details>
<details>
<summary>EqualityPlayground</summary>
<pre>
<code>
#!/usr/bin/env amm

@main
case class User(name: String, age: Int, email: String)
def EqualityPlayground(args: String*) = {
 /**
    * Equality
    */
  // TYPE CLASS
  trait Equal[T] {
    def apply(a: T, b: T): Boolean
  }
  object Equal {
    def apply[T](a: T, b: T)(implicit equalizer: Equal[T]): Boolean =
      equalizer.apply(a, b)
  }

  implicit object NameEquality extends Equal[User] {
    override def apply(a: User, b: User): Boolean = a.name == b.name
  }
  object FullEquality extends Equal[User] {
    override def apply(a: User, b: User): Boolean = a.name == b.name && a.email == b.email
  }

  /*
    Exercise - improve the Equal TC with an implicit conversion class
    ===(another value: T)
    !==(another value: T)
   */
  implicit class TypeSafeEqual[T](value :T) {
    def ===(another: T)(implicit equalizer: Equal[T]): Boolean = equalizer.apply(value, another)
    def !==(another: T)(implicit equalizer: Equal[T]): Boolean = ! equalizer.apply(value, another)
  }

  val testCode1 = {
    val john = User("Jon", 44, "jon@example.com")
    val anotherJohn = User("Jon", 44, "jon@example.com")

    println(john === anotherJohn) // => true
    /*
    john.===(anotherJohn)
    new TypeSafeEqual[User](john).===(anotherJohn)
    new TypeSafeEqual[User](john).===(anotherJohn)(NameEquality)
     */
  }
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

