# MoonBit Motion Lab Examples

This directory contains example programs demonstrating the motion-curve toolkit.

## Basic Example

The `basic/` directory shows fundamental usage:
- Applying parameterized motion curves to value interpolation
- Generating fixed-rate timeline frames
- Evaluating custom cubic Bezier curves
- Inspecting curve diagnostics

## Running Examples

```bash
cd examples/basic
moon run
```

## Example Output

The basic example demonstrates:
1. A parameterized spring curve
2. Custom Bezier curve evaluation
3. Curve profiling and endpoint diagnostics
4. Sequential timeline compilation

## Integration with other MoonBit projects

The package can be combined with rendering or color libraries by passing sampled values to those libraries. This project itself stays renderer-independent.

## More Examples Coming Soon

- Curve tuning and diagnostics
- Data visualization transitions
- Fixed-rate timeline export
