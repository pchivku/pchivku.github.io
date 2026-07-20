---
title: "Curriculum Reinforcement Learning"
order: 4
summary: "Physics-informed curriculum learning for path tracking in underactuated robotic systems."
thumbnail: /files/Overview_curr.png
---

We developed a reinforcement-learning framework for path tracking in a reduced-order bio-inspired swimmer with a passive appendage, using a Chaplygin sleigh with a passive appendage as a surrogate model.

<img src="/files/Overview_curr.png" alt="Curriculum reinforcement learning overview" width="800">
<img src="/files/Other_fig.png" alt="Path-tracking results" width="800">
<video autoplay muted loop playsinline width="800"><source src="/files/Path_tracking_cs.mp4" type="video/mp4"></video>

We pre-trained the actor network using known system physics, then used curriculum-based training to improve learning speed and track trajectories across varied paths and system parameters.

**Paper:** P. Chivkula, C. Rodwell, and P. Tallapragada, *Modeling, Estimation and Control Conference (MECC)*, 2022. [Conference article](https://doi.org/10.1016/j.ifacol.2022.11.207)
