---
layout: page
title: "Categories"
date: 2013-05-23 12:00
comments: false
sharing: false
footer: true
---
<ul>
{% for item in site.categories %}
    <li><a href="/blog/categories/{{ item[0] | downcase }}/">{{ item[0] | captialize }}</a> [ {{ item[1].size }} ]</li>
{% endfor %}
</ul>
