---
layout: post
author: friendbear
title: Vim
---

### Vim 


### Install Software
- [SpaceVim](https://github.com/SpaceVim/SpaceVim)

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
<https://spacevim.org/documentation/>

### Usefull Link
<https://github.blog/2019-01-20-release-radar-december-2018/>
### Recommend
