---
layout: post
author: friendbear
title: 01/22 JDK on Amazon, Security, CRM Setup, and other
---

### Java Tips
- [Amazon Corretto](https://docs.aws.amazon.com/ja_jp/corretto/latest/corretto-8-ug/downloads-list.html)
    - twitter support

### Security 
- DNS Hosts file
<https://github.com/drduh/macOS-Security-and-Privacy-Guide#hosts-file>
```
$ curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts | sudo tee -a /etc/hosts

$ wc -l /etc/hosts
65580

$ egrep -ve "^#|^255.255.255|^0.0.0.0|^127.0.0.1|^0 " /etc/hosts | sort | uniq | sort
::1 localhost
fe80::1%lo0 localhost
[should not return any other IP addresses]
```

#### DNSCrypt-proxy
<https://github.com/drduh/macOS-Security-and-Privacy-Guide#dnscrypt>

```
$ brew info dnsproxy
$ brew info dnscrypt-proxy
dnscrypt-proxy: stable 2.0.19 (bottled), HEAD
Secure communications between a client and a DNS resolver
https://github.com/jedisct1/dnscrypt-proxy
/usr/local/Cellar/dnscrypt-proxy/2.0.19 (12 files, 11.8MB) *
  Poured from bottle on 2019-01-15 at 09:27:12
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/dnscrypt-proxy.rb
==> Dependencies
Build: go ✔
==> Options
--HEAD
	Install HEAD version
==> Caveats
After starting dnscrypt-proxy, you will need to point your
local DNS server to 127.0.0.1. You can do this by going to
System Preferences > "Network" and clicking the "Advanced..."
button for your interface. You will see a "DNS" tab where you
can click "+" and enter 127.0.0.1 in the "DNS Servers" section.

By default, dnscrypt-proxy runs on localhost (127.0.0.1), port 53,
balancing traffic across a set of resolvers. If you would like to
change these settings, you will have to edit the configuration file:
  /usr/local/etc/dnscrypt-proxy.toml

To check that dnscrypt-proxy is working correctly, open Terminal and enter the
following command. Replace en1 with whatever network interface you're using:

  sudo tcpdump -i en1 -vvv 'port 443'

You should see a line in the result that looks like this:

 resolver.dnscrypt.info

To have launchd start dnscrypt-proxy now and restart at startup:
  sudo brew services start dnscrypt-proxy
```
```shell
$ sudo brew services restart dnscrypt-proxy
```

```shell
$ sudo lsof -Pni UDP:5355
COMMAND     PID   USER   FD   TYPE            DEVICE SIZE/OFF NODE NAME
dnscrypt- 16387 nobody    7u  IPv4 0xc0d1987dc8b08a3      0t0  UDP 127.0.0.1:5355
dnscrypt- 16387 nobody   10u  IPv6 0xc0d1987dc8b2bfb      0t0  UDP [::1]:5355
dnscrypt- 16387 nobody   12u  IPv4 0xc0d1987dc8b08a3      0t0  UDP 127.0.0.1:5355
dnscrypt- 16387 nobody   14u  IPv6 0xc0d1987dc8b2bfb      0t0  UDP [::1]:5355
```

* Stars
  - <https://github.com/Cofyc/dnscrypt-wrapper>

### Dnsmasq setup faild
Try again
<https://github.com/drduh/macOS-Security-and-Privacy-Guide#dnsmasq>

### Install Wireshark
```shell
$ tshark -Y "http.request or http.response" -Tfields   -e ip.dst   -e http.request.full_uri   -e http.request.method   -e http.response.code   -e http.response.phrase   -Eseparator=/s

Capturing on 'Wi-Fi'
239.255.255.250 http://239.255.255.250:1900* M-SEARCH
10.0.1.171   200 OK
10.0.1.171   200 OK
10.0.1.171   200 OK
10.0.1.171   200 OK
10.0.1.35 http://10.0.1.35:8200/rootDesc.xml GET
10.0.1.147 http://10.0.1.147:2869/upnphost/udhisapi.dll?content=uuid:6300ae58-f771-4946-bf51-617e8c5f8385 GET
10.0.1.168 http://10.0.1.168:60000/upnp/dev/976f8f9f-c68d-ec53-0000-00007b3772f0/desc GET
10.0.1.171   200 OK
10.0.1.171   200 OK
```
### Setup CRM
- HubSpot

### Try Scala
- RockScalaAdvanced


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

