# MoonBit Motion Lab Examples

The examples demonstrate how Motion Lab verifies and compiles curves supplied by an application or by a dedicated easing package.

## Basic Example

`basic/` runs three complete workflows:

1. An application supplies its own smoothstep curve and receives a deterministic `CurveReport`.
2. The application checks the curve against a strict endpoint, monotonicity, and overshoot policy.
3. The application compiles sequential value transitions into fixed-rate numeric frames, then rejects a curve whose overshoot violates the same policy.

## Running Examples

```bash
moon run ./examples/basic
```

## Integration Boundary

The example intentionally defines its curve locally. In a real project, the same `MotionFn` can wrap a function selected from `Zlj6566/moonbit-easing` or another curve provider. Motion Lab does not duplicate that provider's named formulas or presets; it consumes a curve as data-processing input and returns diagnostics, policy results, and reproducible frames.
