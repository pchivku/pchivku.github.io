---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---
 <hr style="width:96%;border:solid 1px black;color:#FFFF00;height:1px"> 
# Spin Swimmer: A fast, efficient and agile swimming robot

Marine robots have become indispensable, serving a variety of applications ranging from surveillance to exploration and across a wide range of missions. Fish serve as a natural source of inspiration, having evolved efficient ways to move through water. To replicate and understand this efficiency, engineers and scientists have often attempted to mimic the kinematics of fish-like undulatory motion. While most existing designs rely on mechanical linkages or cable-driven systems involving multiple rigid actuators, in this work, we take a fundamentally new approach. We harness ideas from nonlinear dynamics and design a robot based on the concept of parametric resonance. Our experimental results demonstrate that this one of the most efficient bio-inspired swimming robots. 
The robot design features a rigid hydrofoil body that houses an unbalanced rotor, with a flexible tail attached to the body. Specifically, we use the spin of this internal unbalanced rotor to induce oscillations in a flexible tail, as shown in the movie.

<video id="myBGvid" autoplay muted loop width="800" >
<source src="/files/Spin_rotor_small.mp4" type="video/mp4">
</video>
<video id="myBGvid" autoplay muted loop width="800" >
<source src="/files/Spin_movie_modes_small.mp4" type="video/mp4">
</video>

Once submerged (with only the lid protruding above the water), the robot exhibits different modes of oscillation at various rotor spin frequencies, as seen in the above movie to the right showing the first and second modes. Furthermore, the robot achieves a high swimming speed of 2.4 body lengths per second (BL/s) with a low cost of transport of 1.02, as shown in the video below. 


<!-- <div style="display: flex; align-items: center;"> -->
<video id="myBGvid" autoplay muted loop width="800">
<source src="/files/Spin_swim_strt_small.mp4" type="video/mp4">
</video>
<video id="myBGvid" autoplay muted loop width="800" >
<source src="/files/Spin_movie_underwater_small.mp4" type="video/mp4">
</video>


For more details, see the following paper: 
>Spin Swimmer: A fast, efficient and agile swimming robot \
>P. Chivkula, P. Tallapragada. \
>IEEE Robotics and Automation Letters, 2025. [Journal link](https://doi.org/10.1109/LRA.2025.3606357) \
>More videos [here](https://drive.google.com/file/d/1rnSlfVkf2ZhkzqRtLVeHoHoN8Eo2xuoA/view?usp=drive_link)

<br/>
 <hr style="width:96%;border:solid 1px black;color:#FFFF00;height:1px"> 

# Bistable swimmer
Inspired by the remarkable maneuverability of fish, roboticists and engineers have sought to leverage flexible and multistable mechanisms to enhance the maneuverability of bio-inspired robots. In line with this we developed a novel  underactuated fish-like robot with a passive bistable tail. This robot design
combines a hydrofoil with a bistable tail that features a double-well elastic potential and is
controlled by a single actuator — the internal rotor, as shown in the video below.

<video id="myBGvid" autoplay muted loop width="800">
<source src="/files/Bistable_rotor_small.mp4" type="video/mp4">
</video>
By tuning the amplitude and frequency of the input to the
rotor, the robot transitions between distinct gaits, enabling both straight-line swimming and
powered turning, the latter arising from oscillations about a deflected tail position. This is illustrated in the video below.

<video id="myBGvid" autoplay muted loop width="800">
<source src="/files/Bistable_gaits_small.mp4" type="video/mp4">
</video>

This robot can swim at a top speed of 2.1 BL/s and can perform agile turning maneuvers.

<video id="myBGvid" autoplay muted loop width="800">
<source src="/files/Bistable_strt.mp4" type="video/mp4">
</video>



For more details, see the following papers:  
>Hopping potential wells and gait switching in a fish-like robot with a bistable tail \
>P. Chivkula, C. Rodwell, P. Tallapragada. \
>_Extreme Mechanics Letters_ 72, 102239 November 2024. [Journal Link](https://doi.org/10.1016/j.eml.2024.102239) 


# Rolling, Jumping Robot
Inspired by Littlewood’s hopping hoop—a classic dynamics example involving a lightweight ring with a heavy eccentric mass that hops when rolled rapidly or released on an incline as shown in this [video](/files/Passive_hoop.mp4)
This hopping behaviour is due to a lifting effect on the hoop created by the large centripetal acceleration of the offset mass.  Building on this idea, we designed a robot that rolls and jumps from flat ground by actuating an internal pendulum at high speed. As shown in the video below, our robot is capable of achieving vertical jumps of 2.4 body lengths.  
<video controls autoplay muted loop width="600" >
<source src="/files/vertonly.mp4" type="video/mp4">
</video>

Additionally, the robot can clear large horizontal distances while in air by achieving a high rolling velocity before initiating a jump.  As shown in the video below, the robot clears over 6 body lengths in air and is able to achieve multiple jumps with minimal recovery time.  
<video controls autoplay muted loop width="600" >
<source src="/files/horonly.mp4" type="video/mp4">
</video>

For more details, see the following papers:  
>A Pendulum-Driven Legless Rolling Jumping Robot\
>J. Buzhardt, P. Chivkula, P. Tallapragada. \
>IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS), 2023 [Conference article](https://doi.org/10.1109/IROS55552.2023.10342513) 

<br/>
 <hr style="width:96%;border:solid 1px black;color:#FFFF00;height:1px"> 

# Curriculum Reinforcement Learning

Underactuated mechanical systems with nonholonomic constraints play a key role in bio-inspired robotics, from snake-like to fish-like designs, and serve as effective reduced-order models for studying their locomotion dynamics.
For instance, certain aquatic robots exhibit Chaplygin-sleigh-like dynamics, showing figure-eight limit cycles in reduced velocity space under periodic torque, as confirmed by both experiments and simulations.
Due to their complex dynamics path tracking in such systems is not straightforward. To address this, we developed a reinforcement-learning control framework for a reduced-order model of a bio-inspired swimming robot featuring a passive appendage. Using a Chaplygin sleigh with a passive appendage as a surrogate model, we trained a policy-gradient agent to perform path tracking.
 
<img src="/files/Overview_curr.png" alt="Rotor controls" width="400">
<img src="/files/Other_fig.png" alt="Rotor controls" width="400">
 <video id="myBGvid" autoplay muted loop width="400">
    <source src="/files/Path_tracking_cs.mp4" type="video/mp4">
  </video> 
To accelerate learning and embed prior structure, we pre-trained the actor network using known system physics and used it to initialize the agent’s training. We also devised a curriculum-based training strategy to further speed up learning and enable the model to track trajectories across a range of paths and system parameters.

For more details, see the following papers:  
>A Pendulum-Driven Legless Rolling Jumping Robot\
>P. Chivkula, C. Rodwell, P. Tallapragada. \
>Modeling, Estimation and Control Conference (MECC), 2022 [Conference article](https://doi.org/10.1016/j.ifacol.2022.11.207) 
