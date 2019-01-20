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
<summary>Future Map</summary>
<pre>
<code class="language-scala">

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

</code>

<code>
</code>
</pre>
</details>

