---
title: "Differentiable Reinforcement Learning"
order: 5
summary: "Differentiable learning of adaptive PID gains for path tracking in swimming robot."
thumbnail: /files/DiffRL/diffrl-thumbnail.png
---

We developed a differentiable reinforcement-learning framework for path tracking in a reduced-order model of a bio-inspired swimming robot. The nonlinear, underactuated dynamics are represented by a modified Chaplygin sleigh.

<img src="/files/DiffRL/diffrl-thumbnail.png" alt="Differentiable reinforcement learning for PID path tracking" width="800">

<video autoplay muted loop playsinline controls width="800" poster="/files/DiffRL/diffrl-thumbnail.png"><source src="/files/DiffRL/iros_video_comp%20-%20Trim.mp4" type="video/mp4"></video>

Using backpropagation through time, a neural-network controller learns adaptive PID gains directly through the system dynamics. Pure-pursuit guidance supplies the reference heading, while each training episode uses a prescribed constant-velocity target. The resulting controller follows the reference velocity and heading when deployed on the robot. 
