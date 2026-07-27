---
title: "Spin Swimmer 2.0"
order: 1
summary: "Spin Swimmer got wings!"
thumbnail_video: /files/AGMPUFL/Multiple_barrel_rolls_trim.mp4
---

<script async src="https://ga.jspm.io/npm:es-module-shims@1.7.1/dist/es-module-shims.js"></script>
<script type="importmap">
  {
    "imports": {
      "three": "https://cdn.jsdelivr.net/npm/three@^0.183.0/build/three.module.min.js"
    }
  }
</script>
<script
  type="module"
  src="https://cdn.jsdelivr.net/npm/@google/model-viewer/dist/model-viewer-module.min.js">
</script>
<script
  type="module"
  src="https://cdn.jsdelivr.net/npm/@google/model-viewer-effects/dist/model-viewer-effects.min.js">
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
      <effect-composer render-mode="quality">
        <outline-effect
          color="#163447"
          strength="1.15"
          smoothing="2">
        </outline-effect>
        <ssao-effect strength="1.1"></ssao-effect>
        <smaa-effect quality="high"></smaa-effect>
        <color-grade-effect contrast=".08"></color-grade-effect>
      </effect-composer>
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
    let animationFrame;

    const showInitialAssembly = () => {
      model.pause();
      model.currentTime = 0;
      model.setAttribute("auto-rotate", "");
      assemble.disabled = true;
      explode.disabled = false;
    };

    const animateTo = (targetTime) => {
      cancelAnimationFrame(animationFrame);
      model.removeAttribute("auto-rotate");
      model.pause();

      const startTime = model.currentTime;
      const distance = Math.abs(targetTime - startTime);
      if (distance < 0.001) return;

      const animationDuration = 1400 * (distance / model.duration);
      const startedAt = performance.now();
      assemble.disabled = true;
      explode.disabled = true;

      const step = (now) => {
        const progress = Math.min((now - startedAt) / animationDuration, 1);
        const eased = progress < .5
          ? 2 * progress * progress
          : 1 - Math.pow(-2 * progress + 2, 2) / 2;

        model.currentTime = startTime + (targetTime - startTime) * eased;

        if (progress < 1) {
          animationFrame = requestAnimationFrame(step);
          return;
        }

        const isExploded = targetTime > 0;
        assemble.disabled = !isExploded;
        explode.disabled = isExploded;
        model.setAttribute("auto-rotate", "");
      };

      animationFrame = requestAnimationFrame(step);
    };

    model.addEventListener("load", showInitialAssembly);
    assemble.addEventListener("click", () => animateTo(0));
    explode.addEventListener("click", () => animateTo(model.duration));
  })();
</script>

<div class="research-video-feature">
  <video autoplay muted loop playsinline preload="metadata">
    <source src="/files/AGMPUFL/AGMPUFL_V1%20-%20Trim_BD.mp4" type="video/mp4">
  </video>
</div>

To learn more about this work and view additional maneuvers, check out the [paper](https://doi.org/10.1109/LRA.2026.3699121).
