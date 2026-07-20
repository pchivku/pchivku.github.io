---
layout: archive
title: "Research Projects"
permalink: /research-thumbnails/
author_profile: true
---

<p class="research-intro">Explore my work in bio-inspired robotics, nonlinear dynamics, and learning-based control.</p>

<div class="research-grid">
{% assign projects = site.research | sort: "order" %}
{% for project in projects %}
  <a class="research-card" href="{{ project.url | relative_url }}" aria-label="Read about {{ project.title }}">
    <div class="research-card__media">
      {% if project.thumbnail_video %}
        <video autoplay muted loop playsinline preload="metadata"><source src="{{ project.thumbnail_video | relative_url }}" type="video/mp4"></video>
      {% else %}
        <img src="{{ project.thumbnail | relative_url }}" alt="">
      {% endif %}
      <span class="research-card__arrow" aria-hidden="true">&#8599;</span>
    </div>
    <div class="research-card__body">
      <h2>{{ project.title }}</h2>
      <p>{{ project.summary }}</p>
      <span class="research-card__link">View project</span>
    </div>
  </a>
{% endfor %}
</div>
