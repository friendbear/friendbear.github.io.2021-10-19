---
layout: post
author: friendbear
---

### Try Scala
- RockScalaAdvanced
  + Functional Collections : A functional Set
  + Curring and Partially Applied Function (Important!)
  + Lazy Evaluation
    + Lazy Evaluation Exercise: A Potentially Infinite Stream


<details>
<summary>Snippet</summary>
<p>
```scala
#!/usr/bin/env amm
@main
def curried(args: String*) = {

  val superAdderOrg: Int => (Int => Int) = (x: Int) => (y: Int) => x + y
  // equal
  val superAdder: Int => Int => Int = // Higher order function 🔴
    x => y => x + y

  // curried functions
  val superAdder2: Int => Int => Int = new Function2[Int, Int, Int] {
    override def apply(x: Int, y: Int): Int = x + y
  } curried

  lazy val add3 = superAdder(3) // Int => Int => y => 3 + y
  println(add3(5)) // Int => 3 + 5
  println(superAdder(3)(5)) // curried function
}
```

```scala
#!/usr/bin/env amm
@main
def filteringWithLazyVals(args: String*) = {

  // filtering with lazy vals
  {
    def lessThan30(i: Int): Boolean = {
      println(s"$i is grater than 30?")
      i < 30
    }

    // filtering with lazy vals
    def graterThan20(i: Int): Boolean = {
      println(s"$i is grater than 20?")
      i > 20
    }

    val numbers = List(1, 25, 40, 5, 23)
    val lt30 = numbers.filter(lessThan30) // List(1, 25, 5, 23)
    val gt20 = lt30.filter(graterThan20) // List(25, 23)

    println(gt20)

    // use withFilter point.
    val it30Lazy = numbers.withFilter(lessThan30) // lazy vals under the head
    val gt20Lazy = it30Lazy.withFilter(graterThan20)
    gt20Lazy.foreach(println)
  }
}
```
</p>
</details>

