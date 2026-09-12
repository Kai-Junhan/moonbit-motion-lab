# MoonBit Motion Lab

MoonBit Motion Lab is a **motion-curve quality-assurance and deterministic timeline toolkit** for MoonBit. It starts after an application has selected a curve, whether the function was written locally or supplied by a separate easing package.

It deliberately does **not** publish named easing equations, CSS easing presets, spring/back formulas, or a cubic-Bezier curve factory. That is the responsibility of an easing library. Motion Lab evaluates the resulting `MotionFn` against product constraints, generates reproducible numeric fixtures, and compiles renderer-independent value timelines.

## What it provides

- the shared `MotionFn` function contract for caller-owned curves
- deterministic sampling, interpolation, local velocity, monotonicity, and overshoot measurements
- `CurveReport` numerical diagnostics: min/max, maximum speed, peak-speed time, monotonicity, and endpoint error
- `CurvePolicy` and `check` for explicit acceptance requirements: endpoint tolerance, monotonicity, overshoot, and speed limits
- `MotionTimeline` for sequential value transitions and fixed-rate frame generation

## Quick start

```moonbit
let smoothstep = fn(t : Double) -> Double { t * t * (3.0 - 2.0 * t) }
let policy = @motion.CurvePolicy::strict()
let result = @motion.check(smoothstep, 120, policy)

let timeline = @motion.MotionTimeline::new()
timeline.append(0.0, 100.0, 0.6, smoothstep)
timeline.append(100.0, 160.0, 0.4, smoothstep)
let frames = timeline.frames(60)
```

The function may instead come from another package:

```moonbit
let selected_curve = fn(t : Double) -> Double { /* invoke an external easing function */ t }
let report = @motion.profile(selected_curve, 120)
```

## Project boundary

`Zlj6566/moonbit-easing` and comparable packages own the selection and implementation of easing formulas. Motion Lab owns curve **inspection**, **acceptance checking**, **deterministic numeric output**, and **timeline compilation**. It is therefore useful when a project needs to prove a selected curve meets a product constraint or needs reproducible values for a renderer, golden test, or offline pipeline.

Out of scope:

- standard or named easing-function catalogues
- CSS `ease`, `ease-in`, `ease-out`, or `ease-in-out` aliases
- spring, back, bounce, elastic, or cubic-Bezier formula implementations
- DOM manipulation, rendering, animation scheduling, or runtime loops

## Verification

```bash
moon fmt --check
moon check
moon test
moon build
moon run ./examples/basic
```

## License

Apache-2.0. See [LICENSE](LICENSE).
