# MoonBit Motion Lab

MoonBit Motion Lab is a **motion-curve composition and quality-assurance toolkit** for MoonBit. It does not publish a catalogue of named, fixed easing equations or CSS easing presets.

## Project boundary

The project starts after a developer has chosen or designed a curve. It provides:

- parameterized motion primitives (`back_in`, `back_out`, `spring_out`)
- custom cubic-Bezier evaluation without CSS preset aliases
- deterministic curve sampling and application-value frame generation
- numerical curve reports: min/max, maximum speed, peak-speed time, monotonicity, and endpoint error
- renderer-independent sequential timelines that compile transitions into fixed-rate frames

Standard named easing collections are intentionally out of scope. This boundary avoids duplicating maintained easing-function packages and makes the project useful for animation tuning, visual regression tests, and data-visualization transitions.

## Quick start

```moonbit
let spring = fn(t : Double) -> Double { @motion.spring_out(t, 4.0, 2.0) }
let report = @motion.profile(spring, 120)
let timeline = @motion.MotionTimeline::new()
timeline.append(0.0, 100.0, 0.6, spring)
timeline.append(100.0, 160.0, 0.4, @motion.linear)
let frames = timeline.frames(60)
```

## Verification

```bash
moon fmt --check
moon check
moon test
moon build
moon run ./examples/basic
```

## Resubmission note

The Mooncakes module is `Kai-Junhan/moonbit-motion-lab`. Rename the GitHub repository to `moonbit-motion-lab` before final submission so its URL, repository name, and package identity consistently reflect the new scope.

## License

Apache-2.0. See [LICENSE](LICENSE).
