---
layout: post
author: friendbear
title:  Scala (Reflection, Part1, Part2, level 9000 A Potentially Infinite Set)
categories: [blog, lang-scala]
tags: [lang-scala]
---

### Try Scala
- RockScalaForAdvanced
  - reflection Part1
  - reflection Part2

  - A Functional Set, level 9000: A Potentially Infinite Set
  - Lazy Evaluation Exercise: A Potentially Infinite Stream


### Message from Daniel
```
Massive Congratulations! Not many people have the guts to go through this kind of material. This is hard, but you've done it. To put things in perspective, only 1% of Scala engineers can even read the code that you've written in this course! You're far ahead of most and you should now have the tools you need to develop anything, however complex or scalable it needs to be. I hope you've enjoyed this course as much as I have. For now, take a step back, congratulate yourself on what you've learned and created and keep on coding! Write your own projects now, improve on what we've built together, have fun with your creations and continue to rock the JVM! Until we meet again, Daniel
```
### kumasora

### Reference

### Usefull Link
- [sqreen](https://my.sqreen.io/login)
### Recommend


### Snippets

<details>
<summary><code>Reflection Part1, 2</code></summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def Reflection(args: String*) = {
  // reflection + macros + quasiquotes => METAPROGRAMING

  case class Person(name: String) {
    def sayMyName(): Unit = println(s"Hi, my name is $name")
  }

  // 0 - import
  import scala.reflect.runtime.{universe => ru}

  // 1 - MIRROR
  val m = ru.runtimeMirror(getClass.getClassLoader)

  // 2 - create a class object = "description"
  val clazz = m.staticClass("typesystem.Reflection.Person") // creating a class object by Name
  // 3 - create a reflected mirror = "can DO things"
  val cm = m.reflectClass(clazz)
  // 4 - get the constructor
  val constructor = clazz.primaryConstructor.asMethod
  // 5 - reflect the constructor
  val constructorMirror = cm.reflectConstructor(constructor)
  // 6 - invoke the constructor
  val instance = constructorMirror.apply("John")

  println(instance)

  // I have an instance
  val p = Person("Mary") // from the wire as a serialized object
  // method name computed from somewhere else
  val methodName = "sayMyName"

  // 1 - mirror
  // 2 - reflect the instance
  val reflected = m.reflect(p)
  // 3 - method symbol
  val methodSymbol = ru.typeOf[Person].decl(ru.TermName(methodName)).asMethod
  // 4 - reflect the method
  val method = reflected.reflectMethod(methodSymbol)
  // 5 - invoke the method

  method.apply()

  // type erasure

  // pp #1: differentiate types at runtime
  val numbers = List(1, 2, 3)
  numbers match {
    case listOfStrings: List[String] => println("list of strings") // => Choose compiler
    case listOfNumbers: List[Int] => println("list of numbers")
  }

  // pp #2: limitations on overloads
  //def processList(list: List[Int]): Int = 42
  //def processList(list: List[String]): Int = 45

  // TypeTags
  // 0 - import
  import ru._

  // 1 - creating a type tag "manually"
  val ttag = typeTag[Person]
  println(ttag.tpe) // typesystem.Reflection.Person

  class MyMap[K, V]
  // 2 - pass type tags as implicit parameters
  def getTypeArguments[T](value: T)(implicit typeTag: TypeTag[T]) = typeTag.tpe match {
    case TypeRef(_, _, typeArguments) => typeArguments
    case _ => List()
  }

  val myMap = new MyMap[Int, String]
  val typeArgs = getTypeArguments(myMap) //(typeTag: TypeTag[MyMap[Int,String]])
  println(typeArgs)

  def isSubtype[A, B](implicit ttagA: TypeTag[A], ttagB: TypeTag[B]): Boolean = {
    ttagA.tpe <:< ttagB.tpe
  }
  class Animal
  class Dog extends Animal
  println(isSubtype[Dog, Animal])

  val symplify = {
    // 3 - method symbol
    val anotherMethodSymbol = typeTag[Person].tpe.decl(ru.TermName(methodName)).asMethod
    // 4 - reflect the method
    val sameMethod = reflected.reflectMethod(anotherMethodSymbol)
    // 5 - invoke the method
    sameMethod.apply()
  }
}
</code>
</pre>
</details>

<details>
<summary><code>-</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def StructuralTypes(args: String*) = {

}

</code>
</pre>
</details>
<details>
<summary><code>-</code></summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def SelfTypes(args: String*) = {
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

