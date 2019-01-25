---
layout: post
author: friendbear
title: Future Promise Very Important Training
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
<summary>-</summary>
<pre>
<code>
#!/usr/bin/env amm

@main
def FuturesPromisesSocialNetwork(args: String*) = {
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
def FuturesPromisesOnlineBanking(args: String*) = {
}

</code>
</pre>
</details>

### kumasora

### Reference

### Usefull Link

### Recommend
