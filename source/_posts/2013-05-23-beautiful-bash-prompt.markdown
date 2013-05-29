---
layout: post
title: "Beautiful Bash Prompt"
description: "Build a beautiful bash prompt, with colors and everything"
date: 2013-05-23 18:14
comments: true
categories: bash
---

---

I have been using linux for several years now, and my bash prompt has been evolving more and more, every time I use it, but I wanted to share with you guys today, what mine looks like, and how yours can look the same.

{% img /images/posts/bash/bash-prompt.png %}

1. First off, we need a file of color codes.

``` sh
git clone https://gist.github.com/5638294.git && mv 5638294/colors.sh ~/ && sudo rm -r 5638294 && chmod +x ~/colors.sh && echo "source ~/colors.sh" >> ~/.bashrc
```

2. Now that we have all the colors sources into the bashrc, we can create the PS1. 
 Take the following, and place it at the bottom of your `~/.bashrc` file, after `source ~/colors.sh`.

``` sh
echo 'export PS1="\n\[$Blue\]+-[\[$Color_Off\]\[$Yellow\]\u\[$Color_Off\]\[$Cyan\]@\[$Color_Off\]\[$Yellow\]\h\[$Color_Off\]\[$Blue\]]-[\[$Color_Off\]\[$White\]\w\[$Color_Off\]\[$Blue\]][\[$Color_Off\]\[$Red\]\T\[$Color_Off\]\[$Blue\]]\[$Color_Off\]\n\[$Blue\]+-\[$Red\][\[$Color_Off\]\[$White\]\$\[$Color_Off\]\[$Red\]]~\[$Color_Off\]"' >> ~/.bashrc
```

3. Then just reopen your prompt, and you've got the new bash prompt!
