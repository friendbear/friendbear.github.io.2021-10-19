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
Build: go âœ”
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

#### Check Firewall
```shell
 /usr/libexec/ApplicationFirewall/socketfilterfw --listapps
ALF: total number of apps = 7

1 :  /Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home/bin/java
 	 ( Allow incoming connections )
```

```shell
$ scutil --dns | head
DNS configuration

resolver #1
  nameserver[0] : 127.0.0.1
  flags    : Request A records, Request AAAA records
  reach    : 0x00030002 (Reachable,Local Address,Directly Reachable Address)

resolver #2
  domain   : local
  options  : mdns
 k22  m6  ~  Posts  master  $ 
 networksetup -getdnsservers "Wi-Fi"
127.0.0.1
 k22  m6  ~  Posts  master  $ 
 dig +dnssec icann.org

; <<>> DiG 9.10.6 <<>> +dnssec icann.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62152
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags: do; udp: 4096
;; QUESTION SECTION:
;icann.org.			IN	A

;; ANSWER SECTION:
icann.org.		599	IN	A	192.0.43.7
icann.org.		599	IN	RRSIG	A 7 2 600 20190203113621 20190113072110 37170 icann.org. PLr/I2F3vtEl7ehskLkj3oBtFkzdeqV7gbmD7Jz5E+4YVdaMiMynQpKu F7hf5EIlUcGbqWIuPyvPX/u7EAET9FiAox5oDNvm+0CU8RIaCTyhkly3 Z6CbOrqjwEe2uQ8wAIfdanhgMqfQ7YYGz0k/jsEAoZQoahCYGcMHDXWl GfQ=

;; Query time: 209 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Tue Jan 22 15:18:41 JST 2019
;; MSG SIZE  rcvd: 241

$ dig www.dnssec-failed.org

; <<>> DiG 9.10.6 <<>> www.dnssec-failed.org
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: SERVFAIL, id: 64166
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1252
;; QUESTION SECTION:
;www.dnssec-failed.org.		IN	A

;; Query time: 389 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Tue Jan 22 15:19:39 JST 2019
;; MSG SIZE  rcvd: 50
```

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
  -  JVM Thread Communication
  -  Producer-Consumer, Level2

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
</code>

<code>
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
          buffer.notify()
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
          buffer.notify()
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

---
  
<summary>kumasora(osu! storyboard)</summary>
<pre>
<code>
// kumasora programming lesson
            var layer = GetLayer("TEST");
            var BG = layer.CreateSprite("back.png", OsbOrigin.Centre);

            BG.Scale(0, 10000, 2, 2);
            BG.Fade(0, 2000, 0, 10);
            BG.Fade(8000, 10000, 10, 0);

</code>
</pre>
</details>

### Usefull Link
<https://codesandbox.io/>
