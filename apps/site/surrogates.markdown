---
layout: page
title: Surrogates
permalink: /surrogates/
---
These are the surrogate digital objects.

<ul>
    {% for item in site.surrogates %}
    <li><a href="{{item.url}}">{{ item.title }}</a></li>
    {% endfor %}
</ul>
