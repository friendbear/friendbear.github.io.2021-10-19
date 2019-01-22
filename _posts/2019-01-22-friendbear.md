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
def ConcurrencyOnJVM(args: String*) = {

}
</code>
</pre>
</details>
<details>
<summary>kumasora</summary>
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

