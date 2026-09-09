fn main {
  println("=== MoonBit Easing Library Demo ===\n")

  // Basic easing
  println("1. Basic Easing Functions:")
  let t = 0.5
  println("  t = 0.5")
  println("  Linear: " + @easing.linear(t).to_string())
  println("  Ease In Quad: " + @easing.ease_in_quad(t).to_string())
  println("  Ease Out Quad: " + @easing.ease_out_quad(t).to_string())
  println("  Ease In Out Cubic: " + @easing.ease_in_out_cubic(t).to_string())
  println("  Ease Out Elastic: " + @easing.ease_out_elastic(t).to_string())
  println("  Ease Out Bounce: " + @easing.ease_out_bounce(t).to_string())

  // Value interpolation
  println("\n2. Value Interpolation:")
  let start = 0.0
  let end = 100.0
  println("  Interpolate from 0 to 100 at t=0.5:")
  println("    Linear: " + @easing.ease_value(start, end, t, @easing.linear).to_string())
  println("    Ease Out Cubic: " + @easing.ease_value(start, end, t, @easing.ease_out_cubic).to_string())
  println("    Ease In Back: " + @easing.ease_value(start, end, t, @easing.ease_in_back).to_string())

  // Animation sequence
  println("\n3. Animation Sequence (10 frames):")
  let frames = @easing.ease_sequence(0.0, 100.0, 10, @easing.ease_out_quad)
  for i = 0; i < frames.length(); i = i + 1 {
    println("  Frame " + i.to_string() + ": " + frames[i].to_string())
  }

  // Cubic Bezier
  println("\n4. Cubic Bezier Easing:")
  let bezier = @easing.CubicBezier::new(0.17, 0.67, 0.83, 0.67)
  println("  Custom Bezier(0.17, 0.67, 0.83, 0.67) at t=0.5: " + bezier.ease(0.5).to_string())

  let css_ease = @easing.ease()
  println("  CSS ease preset at t=0.3: " + css_ease.ease(0.3).to_string())

  // Easing composition
  println("\n5. Easing Composition:")

  let ease_in_fn = fn(t : Double) -> Double { @easing.ease_in_quad(t) }
  let reversed = @easing.reverse_easing(ease_in_fn)
  println("  Ease In Quad at t=0.3: " + ease_in_fn(0.3).to_string())
  println("  Reversed at t=0.3: " + reversed(0.3).to_string())

  let sine_fn = fn(t : Double) -> Double { @easing.ease_in_sine(t) }
  let mirrored = @easing.mirror_easing(sine_fn)
  println("  Mirrored Sine at t=0.5: " + mirrored(0.5).to_string())

  // All easing functions demo
  println("\n6. All Easing Functions at t=0.7:")
  let t2 = 0.7
  println("  Sine: " + @easing.ease_in_out_sine(t2).to_string())
  println("  Expo: " + @easing.ease_in_out_expo(t2).to_string())
  println("  Circ: " + @easing.ease_in_out_circ(t2).to_string())
  println("  Back: " + @easing.ease_in_out_back(t2).to_string())
  println("  Quart: " + @easing.ease_in_out_quart(t2).to_string())
  println("  Quint: " + @easing.ease_in_out_quint(t2).to_string())

  println("\n=== Demo Complete ===")
}
