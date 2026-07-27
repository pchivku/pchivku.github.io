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
      shadow-intensity="1"
      environment-image="neutral"
      exposure="1"
      interaction-prompt="auto"
      loading="eager">
    </model-viewer>

    <button class="research-model-replay" id="fish-assembly-replay" type="button">
      Explode view
    </button>

    <p class="research-model-instructions">
      Drag to rotate · Scroll or pinch to zoom
    </p>
  </div>
</div>

<script>
  (() => {
    const model = document.querySelector("#fish-assembly-model");
    const replay = document.querySelector("#fish-assembly-replay");

    let isExploded = false;

    const showInitialAssembly = () => {
      model.pause();
      model.currentTime = 0;
      model.setAttribute("auto-rotate", "");
    };

    const toggleAssembly = () => {
      model.removeAttribute("auto-rotate");
      model.pause();
      model.timeScale = isExploded ? -1 : 1;
      model.currentTime = isExploded ? model.duration : 0;
      model.play({ repetitions: 1 });
    };

    model.addEventListener("load", showInitialAssembly);
    model.addEventListener("finished", () => {
      isExploded = !isExploded;
      replay.textContent = isExploded ? "Assemble" : "Explode view";
      model.setAttribute("auto-rotate", "");
    });
    replay.addEventListener("click", toggleAssembly);
  })();
</script>

<div class="research-video-feature">
  <video autoplay muted loop playsinline preload="metadata">
    <source src="/files/AGMPUFL/AGMPUFL_V1%20-%20Trim_BD.mp4" type="video/mp4">
  </video>
</div>

To learn more about this work and view additional maneuvers, check out the [paper](https://doi.org/10.1109/LRA.2026.3699121).
