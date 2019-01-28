---
layout: post
author: friendbear
title: Setup Yubico and Scala (A Type Class End-to-end example JSON Serialization)
categories: [blog, lang-scala]
tags: [lang-scala, Security]
---

### Setup YubiKey 5C
* <https://yubico.com/start>
  * Setup Mac
* Yubiko Authenticator
  * Setup Twitter
  * Setup Facebook

### Try Scala
- RockScalaForAdvanced
  - A Type Class End-to-end example: JSON Serialization
    - Very difficulty. but Very Powerfull
  - Scala <> Java Conversions
    - collection.JavaConverters._
  - A Type Class Use Case / The Magnet Pattern

    ```scala
      trait HandleMagnet {
        def apply(): Unit
      }
      def handle(magnet: HandleMagnet) = magnet()

      handle {
        println("Hello, Scala")
        "magnet"
      }
    ```

### Apache Spark2
* <https://github.com/alexarchambault/ammonite-spark>

### Activate AirServer for Mac
* <http://www.airserver.com>


### Install Software
* [enhancd](https://github.com/b4b4r07/enhancd)
* [LinkedIn mobile]

### kumasora

### Reference
* <https://talk.jekyllrb.com/>
* [Yubico](https://www.yubico.com/)

### Usefull Link
* <https://www.linkedin.com/in/friendbear/>
### Recommend
* <https://www.slideshare.net/TaisukeOe/presentations>

### Snippets

<details>
<summary><code>JSONSerialization</code></summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def JSONSerialization(args: String*) = {

  /*
    Users, posts, feeds
    Serialize to JSON
   */
  case class User(name: String, age: Int, email: String)
  case class Post(content: String, createdAt: Date)
  case class Feed(user: User, posts: List[Post])

  /*
    1 - intermediate data types: Int, String, List, Date
    2 - type classes for conversion to intermediate data types
    3 - serialize to JSON
   */
  sealed trait JSONValue { // intermediate data type
    def stringify: String
  }

  final case class JSONString(value: String) extends JSONValue {
    def stringify: String = "\"" + value + "\""
  }
  final case class JSONNumber(value: Int) extends JSONValue {
    def stringify: String = value.toString
  }
  final case class JSONArray(values: List[JSONValue]) extends JSONValue {
    def stringify: String = values.map(_.stringify).mkString("[", ",", "]")
  }

  final case class JSONObject(values: Map[String, JSONValue]) extends JSONValue {
    /*
     {
        name: "John"
        age: 22
        friends: [ ... ]
        latestPost: {
          content: "Scala Rocks"
          date: ...
        }
      }
     */
    def stringify: String = values.map {
      case (key, value) => "\"" + key + "\":" + value.stringify
    }.mkString("{", ",", "}")
  }

  val test1 = {
    val data = JSONArray(
      List(
      JSONObject(
          Map(
            "user" -> JSONString("Daniel"),
            "posts" -> JSONArray(List(
              JSONString("Scala Rocks!"),
              JSONNumber(453)
            ))
          )
        ),
        JSONObject(
          Map(
            "user" -> JSONString("Daniel"),
            "posts" -> JSONArray(List(
              JSONString("Scala Rocks!"),
              JSONNumber(453)
            ))
          )
        )
      )
    )
    println(data.stringify)
  }

  // type class
  /*
    1 - type class
    2 - type class instances (implicit)
    3 - pimp library to use type class instances
   */
  // call stringify on result
  // 2.1
  trait JSONConverter[T] {
    def convert(value: T): JSONValue
  }
  // 2.2
  implicit object StringConverter extends JSONConverter[String] {
    def convert(value: String): JSONValue = JSONString(value)
  }
  // 2.3 conversion
  implicit class JSONOpts[T](value: T) {
    def toJSON(implicit converter: JSONConverter[T]): JSONValue =
      converter.convert(value)
  }

  implicit object NumberConverter extends JSONConverter[Int] {
    def convert(value: Int): JSONValue = JSONNumber(value)
  }
  // custom data types
  implicit object UserConverter extends JSONConverter[User] {
    def convert(user: User): JSONValue = JSONObject(Map(
      "name" -> JSONString(user.name),
      "age" -> JSONNumber(user.age),
      "email" -> JSONString(user.email)
    ))

  }
  implicit object PostConverter extends JSONConverter[Post] {
    def convert(post: Post): JSONValue = JSONObject(Map(
      "content" -> JSONString(post.content),
      "createdAt:" -> JSONString(post.createdAt.toString)
    ))

  }
  implicit object FeedConverter extends JSONConverter[Feed] {
    //def convert(feed: Feed): JSONValue = JSONObject(Map(
    //  "user" -> UserConverter.convert(feed.user),   // TODO
    //  "posts" -> JSONArray(feed.posts.map(PostConverter.convert(_))   // TODO
    //)))
    def convert(feed: Feed): JSONValue = JSONObject(Map(
      "user" -> feed.user.toJSON,
      "posts" -> JSONArray(feed.posts.map(_.toJSON)
      )))
  }

  val test2 = {
    val now = new Date(System.currentTimeMillis())
    val john = User("John", 34, "john@rockthejvm.com")
    val feed = Feed(john, List(
      Post("hello", now),
      Post("look at this cute puppy", now)
    ))
    println(feed.toJSON.stringify)
  }
}
</code>
</pre>
</details>

<details>
<summary><code>ScalaJavaConversions</code></summary>
<pre>
<code>
#!/usr/bin/env amm

import java.{util => ju}
@main
def ScalaJavaConversions(args: String*) = {

  import collection.JavaConverters._

  val javaSet: ju.Set[Int] = new ju.HashSet[Int]()

  val test1 = {
    1 to 5 foreach javaSet.add
    println(javaSet)
  }

  val scalaSet = javaSet.asScala

  /*
  　Iterator
    Iterable
    ju.List - scala.mutable.Buffer
    ju.Set - scala.mutable.Set
    ju.Map - scala.mutable.Map
   */
  import collection.mutable._
  val numbersBuffer = ArrayBuffer[Int](1, 2, 3)
  val juNumbersBuffer = numbersBuffer.asJava

  val numbers = List(1, 2, 3)
  val juNumbers = numbers.asJava
  val backToScala = juNumbers.asScala

  val test2 = {
    println(juNumbersBuffer.asScala eq numbersBuffer)
    println(backToScala eq numbers) // false
    println(backToScala == numbers) // true
  }
  /*
    Exercise
    create a Scala-Java Optional-Option
        .asScala
   */
  class ToScala[T](value: => T) {
    def asScala: T = value
  }
  implicit def asScalaOptional[T](o: ju.Optional[T]): ToScala[Option[T]] = new ToScala[Option[T]](
    if (o.isPresent) Some(o.get) else None
  )

  val test3 ={
    val juOptional: ju.Optional[Int] = ju.Optional.of(2)
    val scalaOption = juOptional.asScala
    println(scalaOption)
  }
}

</code>
</pre>
<details>
<summary><code>A Type Class Use Case / The Magnet Pattern</code></summary>
<pre>
<code>
#!/usr/bin/env amm

import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global
@main
def MagnetPattern(args: String*) = {
  // MagnetPattern is method overloading
  class P2PRequest
  class P2PResponse
  class Serializer[T]
  trait Actor {
    def receive(statusCode: Int): Int
    def receive(request: P2PRequest): Int
    def receive(response: P2PResponse): Int
    def receive[T : Serializer](message: T): Int
    def receive[T : Serializer](message: T, statusCode: Int): Int
    def receive(future: Future[P2PRequest])
    // def receive(future: Future[P2PResponse]): Int => Generics type compile error
    // lots of overloads
  }

  /* Troubles
    1 - type erasure
    2 - lifting doesn't work for all overloads

      val receiveFV = receive _ // ?!

    3 - code duplication
    4 - type interrence and default args

      actor.receive(?!)
   */

  // Magnet Pattern (Type Parameter) 🔴
  trait MessageMagnet[Result] {
    def apply(): Result
  }

  def receive[R](magnet: MessageMagnet[R]): R = magnet.apply()

  implicit class FromP2PRequest(request: P2PRequest) extends MessageMagnet[Int] {
    def apply(): Int = {
      // logic for handling a P2P request
      println("Handling P2P request")
      42
    }
  }
  implicit class FromP2PResponse(response: P2PResponse) extends MessageMagnet[Int] {
    def apply(): Int = {
      // logic for handling a P2P response
      println("Handling P2P response")
      24
    }
  }
  // call a Magnet Pattern
  val test1 = {
    receive(new P2PRequest)
    receive(new P2PResponse)
  }

  // 1 - no more type erasure problems!
  implicit class FromResponseFuture(future: Future[P2PResponse]) extends MessageMagnet[Int] {
    def apply(): Int = 2
  }
  implicit class FromRequestFuture(future: Future[P2PRequest]) extends MessageMagnet[Int] {
    def apply(): Int = 3
  }

  val test2 = {
    println(receive(Future(new P2PRequest)))
    println(receive(Future(new P2PResponse)))
  }

  // 2 - lifting works
  trait MathLib {
    def add1(x: Int) = x + 1
    def add1(x: String) = x.toInt + 1
  }
  // "magnetize"
  trait AddMagnet {
    def apply(): Int // concrete not Type Parameter 🔴
  }
  def add1(magnet: AddMagnet): Int = magnet()

  implicit class AddInt(x: Int) extends AddMagnet {
    override def apply(): Int = x + 1
  }
  implicit class AddString(s: String) extends AddMagnet {
    override def apply(): Int = s.toInt + 1
  }

  val test3 = {
    val addFV = add1 _
    println(addFV(1))
    println(addFV("3"))
    val receiveFV = receive _ // => MessageMagnet[Noting]
  }

  /*
    Drawbacks
    1 - verbose
    2 - harder to read
    3 - you can't name or place default arguments
    4 - call by name  doesn't work correctly
    (exercise: prove it!) (hint; side effects
   */
  class Hander {
    def handle(s: => String): Unit = {
      println(s)
      println(s)
    }
  }
  trait HandleMagnet {
    def apply(): Unit
  }
  def handle(magnet: HandleMagnet) = magnet()

  implicit class StringHandle(s: => String) extends HandleMagnet {
    override def apply(): Unit = {
      println(s)
      println(s)
    }
  }

  def sideEffectMethod(): String = {
    println("Hello Scala")
    "hahaha"
  }
  handle(sideEffectMethod()) // =>
  handle {
    println("Hello, Scala")
    "magnet"
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

