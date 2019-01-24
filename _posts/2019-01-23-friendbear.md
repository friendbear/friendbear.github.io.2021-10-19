---
layout: post
author: friendbear
title: new Vim and other
---

### Vim 
- [SpaceVim](https://github.com/SpaceVim/SpaceVim)

### Install Software

- [jq replaced fx](https://github.com/antonmedv/fx)

```shell
  Examples
    $ echo '{"key": "value"}' | fx 'x => x.key'
    value

    $ echo '{"key": "value"}' | fx .key
    value

    $ echo '[1,2,3]' | fx 'this.map(x => x * 2)'
    [2, 4, 6]

    $ echo '{"items": ["one", "two"]}' | fx 'this.items' 'this[1]'
    two

    $ echo '{"count": 0}' | fx '{...this, count: 1}'
    {"count": 1}

    $ echo '{"foo": 1, "bar": 2}' | fx ?
    ["foo", "bar"]
```
 
[fishshell](fishshell.eom)

<details>
<summary>Snippet</summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def ThreadCommunication(args: String*) = {

  /*
    the producer-consumer problem

    producer -> [ ? ] -> consumer
  */
  class SimpleContainer {
    private var value: Int = 0

    def isEmpty: Boolean = value == 0
    def set(newValue: Int) = value = newValue
    def get = {
      val result = value
      value = 0
      result
    }
  }

  lazy val naive = {
    def naiveProdCons(): Unit = {
      val container = new SimpleContainer

      val consumer = new Thread(() => {
        println("[consumer] waiting...")
        while (container.isEmpty) {
          println("[consumer] actively waiting...")
        }
        println("[consumer] I have consumed " + container.get)
      })

      val producer = new Thread(() => {
        println("[producer] computing...")
        Thread.sleep(500)
        val value = 42
        println("[producer] I have produced, after long work, the value" + value)
        container.set(value) // Change isEmpty => True
      })

      consumer.start
      producer.start
    }
    naiveProdCons()
  }

  // wait and notify
  lazy val smart = {
    /*
      Synchronized
      val someObject = "hello'
      someObject.synchronized {
        // code
      }


      wait() and notify()

      // thread 1
      val someObject = "hello"
      someObject.synchronized {
        // code part 1
        someObject.wait()
        // code part 2
      }

      // thread 2
      someObject.synchronized {
        // code
        someObject.notify()
      }

     */
    def smartProdCons() = {
      val container = new SimpleContainer
      val consumer = new Thread(() => {
        println("[consumer] waiting...")
        container.synchronized{
          container.wait()
        }

        // container must have some value
        println("[consumer] I have consumed " + container.get)
      })

      val producer = new Thread(() => {
        println("[producer] Hard at work...")
        Thread.sleep(2000)
        val value = 42

        container.synchronized {
          println("[producer] I'm producing " + value)
          container.set(value)
          container.notify()
        }
      })
      consumer.start
      producer.start
    }
    smartProdCons()
  }
}
#!/usr/bin/env amm
@main
def ProducerConsumerLevel3(args: String*) = {

  /*
    Prod-cons, level 3

      producer1 -> [ ? ? ? ] =-> consumer1
      producer2 ----^     ^----- consumer2
   */

  class Consumer(id: Int, buffer: mutable.Queue[Int]) extends Thread {
    override def run(): Unit = {
      val random = new Random()

      while(true) {
        buffer.synchronized({
          /*
            producer produces value. two Cons are waiting
            notifies ONE consumer,notifies on buffer
            notifies the other consumer

           */
          /*
          [consumer 1] buffer empty, waiting ...
          [consumer 3] buffer empty, waiting ...
          [consumer 2] buffer empty, waiting ...
          [producer 1] producing 0
          [consumer 1] consumed 0
          [producer 3] producing 0
          Exception in thread "Thread-2" [producer 2] producing 0
          [consumer 2] consumed 0
          java.util.NoSuchElementException: queue empty
            at scala.collection.mutable.Queue.dequeue(Queue.scala:67)
            at concurrency.ProducerConsumerLevel3$Consumer.run(ProducerConsumerLevel3.scala:39)
          [producer 2] producing 1
          why ?
            🔴 This is Point not if use while 🔴
           */
          while (buffer.isEmpty) {
            println(s"[consumer $id] buffer empty, waiting ...")
            buffer.wait()
          }

          // there must be at least ONE value in the buffer
          val x = buffer.dequeue() // OOps.!
          println(s"[consumer $id] consumed " + x)

          // hey producer, there's empty space available, are you lazy?
          buffer.notifyAll()
        })

        Thread.sleep(random.nextInt(500))
      }
    }
  }

  class Producer(id: Int, buffer: mutable.Queue[Int], capacity: Int) extends Thread {
    override def run(): Unit = {
      val random = new Random()
      var i = 0
      while (true) {
        buffer.synchronized {
          while (buffer.size == capacity) {
            println(s"[producer $id] buffer is full, waiting...")
            buffer.wait()
          }
          // there must be at least ONE EMPTY SPACE in the buffer
          println(s"[producer $id] producing " + i)
          buffer.enqueue(i)

          //todo hey consumer, new food for you!
          buffer.notifyAll()
          i += 1
        }
        Thread.sleep(random.nextInt(500))
      }
    }
  }

  def multiProdCons(nConsumers: Int, nProducers: Int) = {
    val buffer: mutable.Queue[Int] = new mutable.Queue[Int]
    val capacity = 3

    (1 to nConsumers).foreach(i => new Consumer(i, buffer).start())
    (1 to nProducers).foreach(i => new Producer(i, buffer, capacity).start())
  }

  multiProdCons(3, 3)
}
</code>
</pre>
</details>
<details>

    
<summary>kumasora(osu! storyboard)</summary>
<pre>
<code>
using OpenTK;
using OpenTK.Graphics;
using StorybrewCommon.Mapset;
using StorybrewCommon.Scripting;
using StorybrewCommon.Storyboarding;
using StorybrewCommon.Storyboarding.Util;
using StorybrewCommon.Subtitles;
using StorybrewCommon.Util;
using System;
using System.Collections.Generic;
using System.Linq;

namespace StorybrewScripts
{
    public class Black : StoryboardObjectGenerator
    {
        public override void Generate()
        {
            var layer = GetLayer("TEST");
            var BG = layer.CreateSprite("back.png", OsbOrigin.Centre);

            BG.Scale(0, 10000, 2, 2);
            BG.Fade(0, 2000, 0, 10);
            BG.Fade(8000, 10000, 10, 0);
        }
    }
    }
</code>
</pre>
</details>

---

### Reference
<https://spacevim.org/documentation/>

### Usefull Link
<https://github.blog/2019-01-20-release-radar-december-2018/>
### Recommend
