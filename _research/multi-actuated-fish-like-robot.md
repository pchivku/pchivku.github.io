---
title: "Spin Swimmer 2.0"
order: 1
summary: "Spin Swimmer got wings!"
thumbnail_video: /files/AGMPUFL/Multiple_barrel_rolls_trim.mp4
---

<script
  type="module"
  src="https://ajax.googleapis.com/ajax/libs/model-viewer/4.1.0/model-viewer.min.js">
</script>

<div class="research-hero-grid">
  <div class="research-hero-copy">
    <p>Fish-like robots are often constrained by specialized morphologies and single-mode undulatory actuation, limiting their agility, efficiency, and versatility. Extending our Spin Swimmer platform, we present a fish-like robot combining an unbalanced rotor, a flexible tail, and two independently controlled fins for three-dimensional locomotion. Multiple actuation modes provide a broader range of efficient, motion primitives, which are integrated with attitude control to achieve complex maneuvers, while maintaining actuator redundancy.</p>
  </div>

  <div class="research-model-feature">
    <model-viewer
      id="fish-assembly-model"
      src="/files/AGMPUFL/Fish_assembly_exploded.glb"
      alt="Exploded assembly of the multi-actuated fish-like robot"
      animation-name="ExplodedAssembly"
      camera-controls
      touch-action="pan-y"
      rotation-per-second="12deg"
      shadow-intensity="1.8"
      shadow-softness=".65"
      environment-image="neutral"
      tone-mapping="aces"
      exposure=".68"
      interaction-prompt="auto"
      loading="eager">
    </model-viewer>

    <div class="research-model-controls">
      <button class="research-model-button" id="fish-assemble" type="button">
        Assemble
      </button>
      <button class="research-model-button" id="fish-explode" type="button">
        Explode
      </button>
    </div>

    <p class="research-model-instructions">
      Drag to rotate · Scroll or pinch to zoom
    </p>
  </div>
</div>

<script>
  (() => {
    const model = document.querySelector("#fish-assembly-model");
    const assemble = document.querySelector("#fish-assemble");
    const explode = document.querySelector("#fish-explode");

    const showInitialAssembly = () => {
      model.pause();
      model.currentTime = 0;
      model.setAttribute("auto-rotate", "");
      assemble.disabled = true;
      explode.disabled = false;
    };

    const playTo = (exploded) => {
      model.removeAttribute("auto-rotate");
      model.pause();
      model.timeScale = exploded ? 1 : -1;
      model.currentTime = exploded ? 0 : model.duration;
      assemble.disabled = true;
      explode.disabled = true;
      model.play({ repetitions: 1 });
    };

    model.addEventListener("load", showInitialAssembly);
    model.addEventListener("finished", () => {
      const isExploded = model.timeScale > 0;
      assemble.disabled = !isExploded;
      explode.disabled = isExploded;
      model.setAttribute("auto-rotate", "");
    });
    assemble.addEventListener("click", () => playTo(false));
    explode.addEventListener("click", () => playTo(true));
  })();
</script>

<div class="research-video-feature">
  <video autoplay muted loop playsinline preload="metadata">
    <source src="/files/AGMPUFL/AGMPUFL_V1%20-%20Trim_BD.mp4" type="video/mp4">
  </video>
</div>

To learn more about this work and view additional maneuvers, check out the [paper](https://doi.org/10.1109/LRA.2026.3699121).
