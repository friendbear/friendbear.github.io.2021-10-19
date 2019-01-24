---
layout: post
author: friendbear
title: Developer account approved and other
---

### Twitter Developer account approved 
<https://developer.twitter.com>
- Use Apache Spark 

### visasq Joind
<https://service.visasq.com/>

### AWS SMS setup
- setup google SMTP setting

### Create GitHub repository
- SpaceVim.d repository for SpaceVim

### New Browser
[Sushi Browser](https://sushib.me/)

### Install Software
[nnn](https://github.com/jarun/nnn)

Usage:
```
usage: nnn [-b key] [-C] [-e] [-i] [-l]
           [-p file] [-S] [-v] [-h] [PATH]

The missing terminal file manager for X.

positional args:
  PATH   start dir [default: current dir]

optional args:
 -b key  open bookmark key
 -C      disable directory color
 -e      use exiftool for media info
 -i      nav-as-you-type mode
 -l      light mode
 -p file selection file (stdout if '-')
 -S      disk usage mode
 -v      show version
 -h      show help
```

Keyboad shortcuts (Press ?)
```
 NAVIGATION
         ↑, k  Up           PgUp, ^U  Scroll up
         ↓, j  Down         PgDn, ^D  Scroll down
         ←, h  Parent dir          ~  Go HOME
      ↵, →, l  Open file/dir       &  Start dir
  Home, g, ^A  First entry         -  Last visited dir
   End, G, ^E  Last entry          .  Toggle show hidden
            /  Filter        Ins, ^T  Toggle nav-as-you-type
            b  Pin current dir    ^W  Go to pinned dir
      Tab, ^I  Next context        d  Toggle detail view
        `, ^/  Leader key   N, LeadN  Go to/create context N
          Esc  Exit prompt        ^L  Redraw/clear prompt
           ^G  Quit and cd         q  Quit context
        Q, ^Q  Quit                ?  Help, config
 FILES
           ^O  Open with...        n  Create new/link
            D  File details       ^R  Rename entry
        ⎵, ^K  Copy entry path     r  Open dir in vidir
        Y, ^Y  Toggle selection    y  List selection
            P  Copy selection      X  Delete selection
            V  Move selection     ^X  Delete entry
            f  Archive entry       F  List archive
           ^F  Extract archive  m, M  Brief/full media info
            e  Edit in EDITOR      p  Open in PAGER
 ORDER TOGGLES
           ^J  Disk usage          S  Apparent du
            t  Modification time   s  Size
 MISC
        !, ^]  Spawn SHELL in dir  C  Execute entry
        R, ^V  Run custom script   L  Lock terminal
           ^S  Run a command   N, ^N  Take note
```
<details>
<summary>Snippet</summary>
<pre>
<code>
#!/usr/bin/env amm
@main
def ThreadCommunicationPart3(args: String*) = {

  /*
    Exercise.
   */

  // 1) think of an example where notifyAll acts in a different way than notify?
  def testNotifyAll(): Unit = {
    val bell = new Object

    (1 to 10).foreach(i => new Thread(() => {
      bell.synchronized {
        println(s"[thread $i]  waiting ...")
        bell.wait()

        println(s"[thread $i] hooray!")
      }
    }).start())

    new Thread(() => {
      Thread.sleep(2000)
      println("[announcer] Rock'n roll!")
      bell.synchronized {
        bell.notifyAll() // 🔴 All synchronized wait Object notify
      }
    }).start()
  }
  testNotifyAll()

  // 2) create a deadlock
  case class Friend(name: String) {
    def bow(other: Friend) = {
      this.synchronized {
        println(s"$this: I am bowing to my friend $other")
        other.rize(this)
        println(s"$this: I am rising to my friend $other")
      }
    }
    def rize(other: Friend) = {
      this.synchronized{
        println(s"$this: I am rising to my friend $other")
      }
    }

    // 3
    var side = "right"
    def switchSide(): Unit = {
      if (side == "right") side = "left"
      else side = "right"
    }
    def pass(other: Friend): Unit = {
      while (this.side == other.side) {
        println(s"$this: Oh, but please $other, feel free to pass ...")
        switchSide()
        Thread.sleep(1000)
      }
    }
  }
  val sam = Friend("Sam")
  val pierre = Friend("Pierre")

  val deadLock = {
    new Thread(() => sam.bow(pierre)).start() // sam's lock,    |   then pierre's lock
    new Thread(() => pierre.bow(sam)).start() // pierre's lock, |   then sam's lock
  }
  // 3) create a livelock
  val liveLock = {
    new Thread(() => sam.pass(pierre)).start()
    new Thread(() => pierre.pass(sam)).start()
  }

  liveLock
}
<code>
#!/usr/bin/env amm
@main
def ProducerConsumerLevel3(args: String*) = {
}
</code>
</pre>
</details>
<details>

    
<summary>kumasora(osu! storyboard)</summary>
<pre>
<code>
</code>
</pre>
</details>

---

### Reference

### Usefull Link

### Recommend
