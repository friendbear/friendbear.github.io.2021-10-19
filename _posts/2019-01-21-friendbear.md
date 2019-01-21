---
layout: post
author: friendbear
title: 01/21 Scala and other Try.
---

### Try Scala
- RockScalaAdvanced
  + AdvancedFunctional Programing
    + Monads (is very important 🔴
  + Functional Concurrent Programming
    + Intro to Parallel Programming on the JVM
    + Concurrency Problems on the JVM 


```scala
/**
  * - Monads is very important 🔴
  *
  * trait MonadTemplate[A] {
  *   def unit(value: A): MonadTemplate[A] // also called pure or apply
  *   def flatMap[B](f: A => MonadTemplate[B]: MonadTemplate[B] // also called bind
  * }
  *
  * List, Option, Try, Future, Stream, Set are all monads.
  *
  * Example: List
  * Left identity:
  *   List(x).flatMap(f) = f(x) ++ Nil.flatMap(f) = f(x)
  *
  * Right identity:
  *   list.flatMap(x => List(x)) = list
  *
  * Associativity:
  *   [a b c].flatMap(f).flatMap(g) =
  *   (f(a) ++ f(b) ++ f(c)).flatMap(g) =
  *   f(a).flatMap(g) ++ f(b).flatMap(g) ++ f(c).flatMap(g) =
  *   [a b c].flatMap(f(_).flatMap(g)) =
  *   [a b c].flatMap(x => f(x).flatMap(g))
  *
  * Example: Option
  * Left identity:
  *   Option(x).flatMap(f) = f(x)
  *   Some(x).flatMap(f) = f(x)
  *
  * Right identity:
  *   opt.flatMap(x => Option(x)) = opt
  *
  *   Some(v).flatMap(x => Option(x)) =
  *   Option(v) =
  *   Some(v)
  * Associativity
  *   o.flatMap(f).flatMap(g) = o.flatMap(x => f(x).flatMap(g))
  *
  *   Some(v).flatMap(f).flatMap(g) = f(v).flatMap(g)
  *   Some(v).flatMap(x => f(x).flatMap(g) = f(v).flatMap(g)
  */
```



<details>
<summary>Snippet</summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def monads(args: String*) = {
  // our own Try monad
  trait Attempt[+A] {
    def flatMap[B](f: A => Attempt[B]): Attempt[B]
  }

  object Attempt {
    def apply[A](a: => A): Attempt[A] = // call by name
      try {
        Success(a)
      } catch {
        case e: Throwable => Fail(e)
      }
  }

  case class Success[+A](value: A) extends Attempt[A] {
    def flatMap[B](f: A => Attempt[B]): Attempt[B] =
      try {
        f(value)
      } catch {
        case e: Throwable => Fail(e)
      }
  }

  case class Fail(e: Throwable) extends Attempt[Nothing] {
    def flatMap[B](f: Nothing => Attempt[B]): Attempt[B] = this
  }

  /*
   * left-identity
   *
   * unit.flatMap(f) = f(x)
   * Attempt(x).flatMap(f) = f(x) // Success case!
   * Success(x).flatMap(f) = f(x) // proved.
   *
   * right-identity
   *
   * attempt.flatMap(unit) = attempt
   * Success(x).flatMap(x => Accept(x)) = Accept(x) = Success(x)
   *
   * Fail(e).flatMap(...) = Fail(e)
   *
   * associativity
   *
   * attempt.flatMap(f).flatMap(g) == attempt.flatMap(x => f(x).flatMap(g))
   * Fail(e).flatMap(f).flatMap(g) = Fail(e)
   * Fail(e).flatMap(x => f(x).flatMap(g)) + Fail(e)
   *
   * Success(v).flatMap(f).flatMap(g) =
   *   f(v).flatMap(g) OR Fail(e)
   *
   * Success(v).flatMap(x => f(x).flatMap(g)) =
   *   f(v).flatMap(g) OR Fail(e)
   */

  val attempt = Attempt {
    throw new RuntimeException("My own monad, yes!")
  }

  println(attempt)

  /*
    EXERCISE:
    1) implement a Lazy[T] monad = computation which will only be executed when it's needed.

    unit/apply
    flatMap
   */
  // 1 - Lazy monad
  class Lazy[+A](value: => A) {
    // call by need
    private lazy val internalValue = value
    def use: A = internalValue
    def flatMap[B](f: (=>A) => Lazy[B]): Lazy[B] = f(internalValue)
  }
  object Lazy {
    def apply[A](value: =>A): Lazy[A] = new Lazy(value)
  }
  val lazyInstance = Lazy {
    println("Today I don't feel like doing anything")
    42
  }

  println(lazyInstance.use)

  val flatMappedInstance = lazyInstance.flatMap(x => Lazy {
    10 * x
  })
  val flatMappedInstance2 = lazyInstance.flatMap(x => Lazy {
    10 * x
  })
  flatMappedInstance.use
  flatMappedInstance2.use
}
</code>

<code>
#!/usr/bin/env amm
@main
def ConcurrencyOnJVM(args: String*) = {
  /**
    * Exercises
    * 1) Construct 50 "inception" threads
    *     Thread1 -> Thread2 -> Thread3 -> ...
    *     println("hello from thread #3)
    *   in REVERSE ORDER
    */
  {
    def inceptionThreads(maxThreads: Int, i: Int = 1): Thread = new Thread(() => {
      if (i < maxThreads) {
        val newThread = inceptionThreads(maxThreads, i + 1)
        newThread.start()
        newThread.join()
      }
      println(s"Hello from thread $i")
    })

    inceptionThreads(50).start()
  }

  /*
   * 2
   */
  var x = 0
  val threads = (1 to 100).map(_ => new Thread(() => x += 1))
  threads.foreach(_.start())

  /*
   * 1) what is the biggest value possible for x? 100
   * 2) what is the  SMALLEST value possible for x? 1
   *
   * thread1: x = 0
   * thread2: x = 0
   * ....
   * thread100: x = 0
   *
   * for all threads: x = 1 and write it back to x
   */

  println(x)
  threads.foreach(_.join())
  println(x)
}
</code>
</pre>
</details>

