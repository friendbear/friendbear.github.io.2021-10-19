---
layout: post
author: friendbear
title: Future Promise Very Important Training and Docker
---


### Try Scala
- RockScalaForAdvanced
  - Futures, Part4 + Exercises
  - Scala & JVM Standard Parallel Libraries
    - parallel collections (par, Par)
      - Map-reduce model
      - synchronization
      - alternatives
    - atomic ops and references
  - Enter Implicits
  - Ordering Implicits
  - TypeClasses
    - trait HTMLSerializer[T] vs trait HTMLWritable
    - TYPE CLASS

```scala
trait MyTypeClassTemplate[T] {
  def action(value: T): String
}
```

#### Docker sbt
```build.sbt
// ref: https://sbt-native-packager.readthedocs.io/en/stable/formats/docker.html
//      https://github.com/marcuslonnberg/sbt-docker
enablePlugins(sbtdocker.DockerPlugin, JavaAppPackaging)
enablePlugins(DockerSpotifyClientPlugin)


dockerfile in docker := {
  val appDir: File = stage.value
  val targetDir = "/app"

  new Dockerfile {
    from("openjdk:8-jre")
    entryPoint(s"$targetDir/bin/${executableScriptName.value}")
    copy(appDir, targetDir, chown = "daemon:daemon")
  }
}
```

```plugins.sbt
// https://github.com/sbt/sbt-native-packager
addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.3.16")

// https://github.com/marcuslonnberg/sbt-docker
addSbtPlugin("se.marcuslonnberg" % "sbt-docker" % "1.5.0")
libraryDependencies += "com.spotify" % "docker-client" % "8.9.0"
```

#### Update Metals 0.4

### spacevim
[documentation](https://spacevim.org/documentation/#core-pillars)

### kumasora

### Reference
[Editor Config](https://editorconfig.org/)
[ScalaDoc](https://docs.scala-lang.org/style/scaladoc.html)
### Usefull Link
[Git Command Explorer](https://gitexplorer.com/)
[elastic](https://www.elastic.co/jp/products)
[sbt-native-packager](https://sbt-native-packager.readthedocs.io/en/stable/)

### Recommend


### Snippets

<details>
<summary>FuturesPromisesFinal</summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def FuturesPromisesFinal(args: String*) = {
  /*
    1) fulfill a future IMMEDIATELY with a value
    2) inSequence(fa, fb)
    3) first(fa, fb) => new future with the first value of the two futures
    4) last(fa, fb) => new future with the last value
    5) retryUntil[T](action: () => Future[T], condition: T=> Boolean): Future[T]
   */

  // 1 - fulfill immediately
  def fulfillImmediately[T](value: T): Future[T] = Future(value)

  // 2 - inSequence
  def inSequence[A, B](first: Future[A], second: Future[B]): Future[B] =
    first.flatMap(_ => second)

  // 3 - first out of two futures
  def first[A](fa: Future[A], fb: Future[A]): Future[A] = {
    val promise = Promise[A]
    fa.onComplete {
      case Success(r) => try {
        promise.success(r)
      } catch {
        case _ =>
      }
      case Failure(t) => try {
        promise.failure(t)
      } catch {
        case _ =>
      }
    }
    fb.onComplete {
      case Success(r) => try {
        promise.success(r)
      } catch {
        case _ =>
      }
      case Failure(t) => try {
        promise.failure(t)
      } catch {
        case _ =>
      }
    }
    promise.future
  }

  def firstRefactor[A](fa: Future[A], fb: Future[A]): Future[A] = {
    val promise = Promise[A]

    def tryComplete(promise: Promise[A], result: Try[A]) = result match {
      case Success(r) => try {
        promise.success(r)
      } catch {
        case _ =>
      }
      case Failure(t) => try {
        promise.failure(t)
      } catch {
        case _ =>
      }
    }

    fa.onComplete(result => tryComplete(promise, result))
    fb.onComplete(tryComplete(promise, _))
    promise.future
    }

    def firstRefactorUsePromiseTryComplete[A](fa: Future[A], fb: Future[A]): Future[A] = {
      val promise = Promise[A]
      fa.onComplete(promise.tryComplete(_))
      fb.onComplete(promise.tryComplete)
      promise.future
    }

  // 4 - last out of the two futures

  def last[A](fa: Future[A], fb: Future[A]): Future[A] = {
    // 1 promise which both futures will try to complete
    // 2 promise which the LAST future will complete
    val bothPromise = Promise[A]
    val lastPromise = Promise[A]
    val checkAndComplete = (result: Try[A]) =>
      if(!bothPromise.tryComplete(result))
        lastPromise.complete(result)
    /*
    fa.onComplete(result => {
      if (!bothPromise.tryComplete(result))
        lastPromise.complete(result)
    })
    fb.onComplete(result => {
      if (!bothPromise.tryComplete(result))
        lastPromise.complete(result)
    })
    */
    fa.onComplete(checkAndComplete)
    fa.onComplete(checkAndComplete)

    lastPromise.future
  }

  val fast = Future {
    Thread.sleep(100)
    42
  }
  val slow = Future {
    Thread.sleep(200)
    45
  }
  first(fast, slow).foreach(f => println("FIRST: " + f))
  last(fast, slow).foreach(l => println("LAST: " + l))

  Thread.sleep(1000)

  // retry until
  {
    def retryUntil[A](action: () => Future[A], condition: A => Boolean): Future[A] =
      action()
        .filter(condition)
        .recoverWith {
          case _ => retryUntil(action, condition)
        }

    val random = new Random()
    val action = () => Future {
      Thread.sleep(100)
      val nextValue = random.nextInt(100)
      println("generated " + nextValue)
      nextValue
    }
    retryUntil(action, (x: Int) => x < 10).foreach(result => println("settled at " + result))
    Thread.sleep(10000)
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
  // 2 - atomic ops and references

  val atomic = new AtomicReference[Int](2)
  val atomicList = List(
    atomic.get(), // thread-safe read
    atomic.set(4), // thread-safe write
    atomic.getAndSet(5), // thread safe combo
    atomic.compareAndSet(38, 56), // if the value is 38, then set to 56
    atomic.updateAndGet(_ + 1),
    atomic.getAndUpdate(_ + 1),
    atomic.accumulateAndGet(12, _ + _),
    atomic.getAndAccumulate(12, _ + _),
    atomic.get()
  ).filter(_ != ())
  atomicList.foreach(println)
  /*
    2
    4
    false
    6
    6
    19
    19
    31
  */
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
  // tuples
  /*
    implicit final class ArrowAssoc[A](private val self: A) extends AnyVal {
      @inline def -> [B](y: B): Tuple2[A, B] = Tuple2(self, y)
      def →[B](y: B): Tuple2[A, B] = ->(y)
    }
   */
  var pair = "Daniel" -> "555"
  val intPair = 1 -> 2

  case class Person(name: String) {
    def greet = s"Hi, my name is $name!"
  }

  implicit def fromStringToPerson(str: String): Person = Person(str)

  println("Peter".greet)  // println(fromStringToPerson("Peter").greet)

  /* Compile Error
  class A {
    def greet: Int = 2
  }
  implicit def fromStringToA(str: String): A = new A
  */
  def increment(x: Int)(implicit amount: Int) = x + amount
  implicit val defaultAmount = 10

  increment(2)
  // NOT default argument
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
  implicit def reverseOrdering(): Ordering[Int] = Ordering.fromLessThan(_ > _)
  implicit val normalOrdering: Ordering[Int] = Ordering.fromLessThan(_ < _)
  println(List(1, 4, 5, 3, 2).sorted(normalOrdering))

  // scala.Predef

  /*
    Implicits: (used as implicit parameters):
      - val/var
      - object
      - accessor methods = defs with no parentheses
   */

  // Exercise
  case class Person(name: String, age: Int)

  val person = List(
    Person("Steve", 30),
    Person("Amy", 22),
    Person("John", 66)
  )

  object AlphabeticNameOrdering {
    implicit val alphabeticOrdering: Ordering[Person] =
      Ordering.fromLessThan((x, y) => x.name.compareTo(y.name) < 0)
  }
  object AgeOrdering {
    implicit val ageOrdering: Ordering[Person] = Ordering.fromLessThan((x, y) => x.age < y.age)
  }

  /*
    Implicit scope
    - normal scope = LOCAL SCOPE
    - imported scope
    - companions of all types involved in the method signature 🔴
      - List
      - Ordering
      - all the types involved = A or any supertype
   */
  // def sorted[B >: A](implicit ord: Ordering[B]): List[B]
  import AgeOrdering._
  println(person.sorted) // => List(Person(Amy,22), Person(Steve,30), Person(John,66))

  /*
    Exercise.

    - totalPrice = most used (%50)
    - by unit count = 25%
    - by unit price = 25%
   */
  case class Purchase(nUnits: Int, unitPrice: Double)
  object Purchase {
    implicit val totalPriceOrdering: Ordering[Purchase] = Ordering.fromLessThan((x, y) => x.nUnits * x.unitPrice > y.nUnits * y.unitPrice)
  }

  object UnitCountOrdering {
    implicit val unitCostOrdering: Ordering[Purchase] = Ordering.fromLessThan(_.nUnits < _.nUnits)
  }
  object UnitPriceOrdering {
    implicit val unitPriceOrdering: Ordering[Purchase] = Ordering.fromLessThan(_.unitPrice < _.unitPrice)
  }
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

  trait HTMLWritable {
    def toHtml: String
  }

  case class User(name: String, age: Int, email: String) extends HTMLWritable {
    override def toHtml: String = s"<div>$name ($age yo) <a href=$email/> </div>"
  }
  User("John", 32, "john@rockthejvm.com").toHtml

  /*
    1 - for the type WE write
    2 - ONE implementation out of quite a number
   */
  // option 2 - pattern matching
  object HTMLSerializerPatternMatching {
    def serializeToHtml(value: Any) = value match {
      case User(n, a, e) => ()
      case _ => ()
    }
  }
  /*
    1 - lost type safety => HTMLSerializerPatternMatching
    2 - need to modify the code every time
    3 - still ONE implementation
   */
  trait HTMLSerializer[T] {
    def serialize(value: T): String
  }
  object UserSerializer extends HTMLSerializer[User] {
    override def serialize(user: User): String =
      s"<div>${user.name} (${user.age} yo) <a href=${user.email}/></div"
  }

  val john = User("John", 32, " john@rockthejvm.com")
  println(UserSerializer.serialize(john))

  // 1 - we can define serializers for other types
  import java.util.Date
  object DateSerializer extends HTMLSerializer[Date] {
    override def serialize(date: Date): String = s"<div>${date.toString()}</div>"
  }

  // 2 - we can define MULTIPLE serializers
  object PartialUserSerializer extends HTMLSerializer[User] {
    def serialize(user: User): String = s"<div>${user.name}</div>"
  }

  // TYPE CLASS
  trait MyTypeClassTemplate[T] {
    def action(value: T): String
  }

  /**
    * Equality
    */
  trait Equal[T] {
    def apply(a: T, b: T): Boolean
  }
  object NameEquality extends Equal[User] {
    override def apply(a: User, b: User): Boolean = a.name == b.name
  }
  object FullEquality extends Equal[User] {
    override def apply(a: User, b: User): Boolean = a.name == b.name && a.email == b.email
  }
  val ken = User("Ken", 32, " ken@rockthejvm.com")
  val bob = User("Bob", 42, " bob@rockthejvm.com")
  println(NameEquality(ken, bob))
  println(FullEquality(ken, bob))
}
</code>
</pre>
</details>

