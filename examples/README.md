# moonbit-easing Examples

This directory contains example programs demonstrating the use of moonbit-easing.

## Basic Example

The `basic/` directory shows fundamental usage:
- Applying easing functions to value interpolation
- Generating animation sequences
- Using cubic Bezier curves
- Composing easing functions (chain, reverse, mirror)

## Running Examples

```bash
cd examples/basic
moon run
```

## Example Output

The basic example demonstrates:
1. Linear vs eased interpolation
2. Different easing curve families (quad, cubic, elastic, bounce)
3. Custom Bezier curves
4. CSS cubic-bezier presets
5. Easing composition utilities

## Integration with moonbit-color

For smooth color animations, combine with moonbit-color:

```moonbit
let red = @color.RGB::from_int(255, 0, 0)
let blue = @color.RGB::from_int(0, 0, 255)

// Generate 60 frames with easing
let frames = @easing.ease_sequence(0.0, 1.0, 60, @easing.ease_out_cubic)
for t in frames {
  let color = @color.RGB::lerp(red, blue, t)
  println(color.to_hex())
}
```

## More Examples Coming Soon

- UI animation patterns
- Physics simulation curves
- Data visualization transitions
- Game development use cases
