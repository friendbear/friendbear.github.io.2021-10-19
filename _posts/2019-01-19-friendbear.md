---
layout: post
author: friendbear
title: Start Blog on pages.github.com
---

## Start This Blog

### Join Slack
[prisma](https://github.com/prisma)

### gocui
- Makefile test and review

### Create my.github.io
- pages.github.io の選択できるテーマの元を調べてclone
- jekyll Rubyの仕組みを調査
  - <https://jekyllrb.com/docs/step-by-step>
  - ref <https://stackoverflow.com/questions/21446165/how-do-i-use-disqus-comments-in-github-pages-blog-markdown>

- Blog on Disqus
  - <https://desiredpersona.com/disqus-comments-jekyll/>


### GitHub
- Star
  - [An online code editor tailored for web application development](https://codesandbox.io)
  - [Prisma enables seamless type-safe database access & declarative data modeling](https://www.prisma.io)
  - [Architect is a Jekyll theme for GitHub Pages](https://pages-themes.github.io/archititect)

### Good by Powerpoint 
- <https://github.com/yhatt/marp/>
  - `brew cask install marp`

#### Example (Raw Markdown)
```markdown
<!-- $theme: gaia -->

# Introducing ==Gaia== theme

#### Marp's new slide theme

###### Created by [Yuki Hattori (@yhatt)](https://github.com/yhatt)

---
<!-- *template: invert -->

> In Greek mythology, **Gaia** also spelled **Gaea**, was the personification of the Earth and one of the Greek primordial deities.
>
> <small>-- *[Gaia (mythology) - Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Gaia_%28mythology%29)*</small>

---
<!-- page_number: true -->

# Overview

**Gaia** is the beautiful presentation theme on Marp!

- ==**New features**==
	1. Title Slides
	2. Highlight
	3. Color scheme

---

# How to use

#### From menu

Select menu: *View :arrow_right: Theme :arrow_right: Gaia*

#### Use directive

Set `gaia` theme by `$theme` Global Directive.


---

# Basic example 1

**Lorem ipsum** dolor *sit* amet, ***consectetur*** adipiscing elit, sed do `eiusmod` tempor ==incididunt== ut labore et dolore ~~magna aliqua~~. :smile:

> Stay Hungry. Stay Foolish. <small>_--Steve Jobs (2005)_</small>

- List A
	1. [Sub list](https://yhatt.github.io/marp/)
	1. Sub list
		- _More Sub list_

---

# Basic example 2


|table|layout|example|
|:--|:-:|--:|
|align to left|align to center|align to right|
|:arrow_left: left|:arrow_left: center :arrow_right:|right :arrow_right:

![70% center](../images/marp.png)

---
<!-- *template: gaia -->

## Introduce new features!!

# ==1.== Title Slides

---

# ==e.g.== This page :yum:

---

## ==Apply centering== to the page<br />that has only headings!

##### Useful to title slide. :laughing:

---

> **==Tips:==**
> Apply vertical centering to quote only page too.

---
<!-- *template: gaia -->

# ==2.== Highlight

---
## Highlight Markup

You can use `==` for ==highlighting blue==.


#### Notice

*Marp would show <span style="background-color:yellow;">yellow marker highlight</span> in Markdown view or default slide theme.*

---
<!-- *template: gaia -->

# ==3.== Color scheme templates
---
# ==Color== scheme templates

Change color scheme *by `template` page directive.*


- **Default** :arrow_left: This page
- Invert
- Gaia (Theme color)

---
<!-- *template: invert -->
# ==Color== scheme templates

Change color scheme *by `template` page directive.*


- Default
- **Invert** :arrow_left: This page
- Gaia (Theme color)

---
<!-- *template: gaia -->
# ==Color== scheme templates

Change color scheme *by `template` page directive.*

<!-- template: gaia -->

- Default
- Invert
- **Gaia** (Theme color) :arrow_left: This page

---
<!-- *template: invert -->

# Templates can use<br />to ==per pages==!

##### with using temporally page directive `<!-- *template: invert -->`

---
<!-- template: gaia -->

# ==That's all!==

## Let's create beautiful slides<br />with ==Marp== + ==Gaia== theme!

---

#### `<!-- $theme: gaia -->` of Marp

###### [![](../images/marp.png)](https://yhatt.github.io/marp)

#### https://yhatt.github.io/marp

```
