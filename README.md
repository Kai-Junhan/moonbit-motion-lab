# moonbit-easing

**Comprehensive easing functions library for MoonBit**

[![CI](https://github.com/Kai-Junhan/moonbit-easing/actions/workflows/ci.yml/badge.svg)](https://github.com/Kai-Junhan/moonbit-easing/actions)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

A complete collection of easing functions for smooth animations and transitions in the MoonBit ecosystem. Includes 30+ classic easing curves, cubic Bezier support, and animation utilities.

*2026 MoonBit September Hackathon Entry*

## Features

### Easing Curves (30+ Functions)
- **Linear** - No acceleration
- **Quadratic** - Ease in/out/in-out
- **Cubic** - Ease in/out/in-out
- **Quartic** - Ease in/out/in-out
- **Quintic** - Ease in/out/in-out
- **Sine** - Ease in/out/in-out
- **Exponential** - Ease in/out/in-out
- **Circular** - Ease in/out/in-out
- **Back** - Overshoot ease in/out/in-out
- **Elastic** - Spring-like ease in/out/in-out
- **Bounce** - Bouncing ease in/out/in-out

### Advanced Features
- ✅ Cubic Bezier curves with Newton-Raphson solver
- ✅ CSS cubic-bezier presets (ease, ease-in, ease-out, ease-in-out)
- ✅ Easing composition (chain, reverse, mirror)
- ✅ Value interpolation utilities
- ✅ Sequence generation for animations

## Installation

```bash
moon add Kai-Junhan/moonbit-easing
```

## Quick Start

### Basic Easing

```moonbit
// Apply easing to a value between 0 and 100
let t = 0.5  // Time progress (0.0 to 1.0)
let value = @easing.ease_value(0.0, 100.0, t, @easing.ease_out_cubic)
println(value.to_string())  // ~87.5

// Try different easing functions
let linear_val = @easing.ease_value(0.0, 100.0, t, @easing.linear)
let bounce_val = @easing.ease_value(0.0, 100.0, t, @easing.ease_out_bounce)
let elastic_val = @easing.ease_value(0.0, 100.0, t, @easing.ease_out_elastic)
```

### Generate Animation Sequences

```moonbit
// Generate 60 frames of animation (1 second at 60fps)
let frames = @easing.ease_sequence(0.0, 100.0, 60, @easing.ease_in_out_quad)

for i = 0; i < frames.length(); i = i + 1 {
  println("Frame " + i.to_string() + ": " + frames[i].to_string())
}
```

### Cubic Bezier Easing

```moonbit
// Create custom cubic Bezier curve
let bezier = @easing.CubicBezier::new(0.17, 0.67, 0.83, 0.67)
let value = bezier.ease(0.5)

// Use CSS presets
let ease = @easing.ease()           // cubic-bezier(0.25, 0.1, 0.25, 1.0)
let ease_in = @easing.ease_in()     // cubic-bezier(0.42, 0, 1.0, 1.0)
let ease_out = @easing.ease_out()   // cubic-bezier(0, 0, 0.58, 1.0)
let ease_in_out = @easing.ease_in_out()  // cubic-bezier(0.42, 0, 0.58, 1.0)

let val = ease.ease(0.3)
```

### Easing Composition

```moonbit
// Reverse an easing function (ease-in becomes ease-out)
let ease_in_quad_fn = fn(t : Double) -> Double { @easing.ease_in_quad(t) }
let ease_out_quad_fn = @easing.reverse_easing(ease_in_quad_fn)

// Mirror an easing (creates ease-in-out style)
let sine_fn = fn(t : Double) -> Double { @easing.ease_in_sine(t) }
let mirrored = @easing.mirror_easing(sine_fn)

// Chain two easing functions (first 50% uses first, second 50% uses second)
let cubic_fn = fn(t : Double) -> Double { @easing.ease_in_cubic(t) }
let bounce_fn = fn(t : Double) -> Double { @easing.ease_out_bounce(t) }
let chained = @easing.chain_easing(cubic_fn, bounce_fn, 0.5)

let value = chained(0.75)  // Uses bounce in second half
```

### All Easing Functions

```moonbit
// Linear
@easing.linear(t)

// Quadratic
@easing.ease_in_quad(t)
@easing.ease_out_quad(t)
@easing.ease_in_out_quad(t)

// Cubic
@easing.ease_in_cubic(t)
@easing.ease_out_cubic(t)
@easing.ease_in_out_cubic(t)

// Quartic
@easing.ease_in_quart(t)
@easing.ease_out_quart(t)
@easing.ease_in_out_quart(t)

// Quintic
@easing.ease_in_quint(t)
@easing.ease_out_quint(t)
@easing.ease_in_out_quint(t)

// Sine
@easing.ease_in_sine(t)
@easing.ease_out_sine(t)
@easing.ease_in_out_sine(t)

// Exponential
@easing.ease_in_expo(t)
@easing.ease_out_expo(t)
@easing.ease_in_out_expo(t)

// Circular
@easing.ease_in_circ(t)
@easing.ease_out_circ(t)
@easing.ease_in_out_circ(t)

// Back (overshoot)
@easing.ease_in_back(t)
@easing.ease_out_back(t)
@easing.ease_in_out_back(t)

// Elastic (spring)
@easing.ease_in_elastic(t)
@easing.ease_out_elastic(t)
@easing.ease_in_out_elastic(t)

// Bounce
@easing.ease_in_bounce(t)
@easing.ease_out_bounce(t)
@easing.ease_in_out_bounce(t)
```

## API Reference

### Core Functions

| Function | Description |
|----------|-------------|
| `ease_value(start, end, t, easing)` | Interpolate between two values with easing |
| `ease_sequence(start, end, steps, easing)` | Generate array of eased values |
| `chain_easing(first, second, split)` | Chain two easing functions |
| `reverse_easing(easing)` | Reverse an easing curve |
| `mirror_easing(easing)` | Create ease-in-out from ease-in |
| `clamp_easing(easing)` | Clamp output to [0, 1] |

### Cubic Bezier

| Method | Description |
|--------|-------------|
| `CubicBezier::new(x1, y1, x2, y2)` | Create custom Bezier curve |
| `bezier.ease(t)` | Evaluate Bezier at time t |
| `ease()` | CSS ease preset |
| `ease_in()` | CSS ease-in preset |
| `ease_out()` | CSS ease-out preset |
| `ease_in_out()` | CSS ease-in-out preset |

## Use Cases

- **UI Animations** - Smooth transitions for buttons, modals, menus
- **Data Visualization** - Animated chart updates and transitions
- **Game Development** - Character movement, camera panning, effects
- **Physics Simulation** - Natural motion curves
- **Interactive Graphics** - SVG animations, canvas rendering
- **Generative Art** - Time-based procedural animation

## Easing Visualization

See [easings.net](https://easings.net) for visual reference of all easing curves.

## Project Structure

```
moonbit-easing/
├── easing.mbt             # Classic easing functions (30+)
├── bezier.mbt             # Cubic Bezier implementation
├── elastic_bounce.mbt     # Elastic & bounce easing
├── utils.mbt              # Composition utilities
├── easing_test.mbt        # 25 unit tests
├── moon.mod.json          # Package metadata
├── moon.pkg.json          # Package config
└── README.md
```

## Testing

```bash
moon test    # Run 25 unit tests
moon check   # Type check
moon build   # Compile
```

All tests pass and cover:
- All 30+ easing functions
- Bezier curve evaluation
- CSS preset curves
- Easing composition (chain, reverse, mirror)
- Value interpolation
- Sequence generation
- Edge cases (t=0, t=1)

## Integration Example

Combine with `moonbit-color` for smooth color transitions:

```moonbit
let red = @color.RGB::from_int(255, 0, 0)
let blue = @color.RGB::from_int(0, 0, 255)

// Generate smooth color gradient with easing
let frames = @easing.ease_sequence(0.0, 1.0, 60, @easing.ease_out_cubic)
for i = 0; i < frames.length(); i = i + 1 {
  let t = frames[i]
  let color = @color.RGB::lerp(red, blue, t)
  println(color.to_hex())
}
```

## References

**Easing Functions:**
- Robert Penner's Easing Functions - http://robertpenner.com/easing/
- easings.net - https://easings.net (CC BY-SA 4.0)
- CSS Easing Functions Level 1 - https://www.w3.org/TR/css-easing-1/

**Cubic Bezier:**
- Bezier Curves - https://en.wikipedia.org/wiki/B%C3%A9zier_curve
- Newton-Raphson Method - https://en.wikipedia.org/wiki/Newton%27s_method

All algorithms re-implemented from scratch in idiomatic MoonBit based on mathematical formulations. No code was copied.

## License

Apache License 2.0 - See [LICENSE](LICENSE)

## Author

Kai-Junhan - 2026 MoonBit September Hackathon

---

<div align="center">

**Built for the 2026 MoonBit Open Source Ecosystem Competition**

</div>
