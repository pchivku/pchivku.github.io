---
title: "Differentiable Reinforcement Learning"
order: 0
summary: "Differentiable learning of adaptive PID gains for path tracking in swimming robot."
thumbnail_video: /files/DiffRL/S_trim.mp4
---

We developed a differentiable reinforcement learning framework for path tracking using a reduced-order model of a bio-inspired swimming robot. Specifically, we employ a modified Chaplygin sleigh model with articulated tail links to enable efficient offline policy training.

<!-- <img src="/files/DiffRL/diffrl-thumbnail.png" alt="Differentiable reinforcement learning for PID path tracking" width="800"> -->

<video autoplay muted loop playsinline controls width="800" poster="/files/DiffRL/diffrl-thumbnail.png"><source src="/files/DiffRL/iros_video_comp%20-%20Trim.mp4" type="video/mp4"></video>

Using backpropagation through time, a neural-network controller learns adaptive PID gains directly through the system dynamics. Pure-pursuit guidance supplies the reference heading, while each training episode uses a prescribed constant-velocity target. The policy trained offline is subsequently deployed on the physical robot to track the reference velocity and heading. 

To learn more about this work, check out our [paper](https://arxiv.org/abs/2607.16508) and for the code check this [repository](https://github.com/kloya03/agilefish-diff-rl).
