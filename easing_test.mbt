test "Linear easing" {
  assert_eq!(linear(0.0), 0.0)
  assert_eq!(linear(0.5), 0.5)
  assert_eq!(linear(1.0), 1.0)
}

test "Ease in quad" {
  assert_eq!(ease_in_quad(0.0), 0.0)
  assert_eq!(ease_in_quad(0.5) > 0.24 && ease_in_quad(0.5) < 0.26, true)
  assert_eq!(ease_in_quad(1.0), 1.0)
}

test "Ease out quad" {
  assert_eq!(ease_out_quad(0.0), 0.0)
  assert_eq!(ease_out_quad(0.5) > 0.74 && ease_out_quad(0.5) < 0.76, true)
  assert_eq!(ease_out_quad(1.0), 1.0)
}

test "Ease in cubic" {
  assert_eq!(ease_in_cubic(0.0), 0.0)
  assert_eq!(ease_in_cubic(0.5) > 0.12 && ease_in_cubic(0.5) < 0.13, true)
  assert_eq!(ease_in_cubic(1.0), 1.0)
}

test "Ease out cubic" {
  assert_eq!(ease_out_cubic(0.0), 0.0)
  assert_eq!(ease_out_cubic(0.5) > 0.87 && ease_out_cubic(0.5) < 0.88, true)
  assert_eq!(ease_out_cubic(1.0), 1.0)
}

test "Ease in sine" {
  assert_eq!(ease_in_sine(0.0), 0.0)
  assert_eq!(ease_in_sine(1.0), 1.0)
}

test "Ease out sine" {
  assert_eq!(ease_out_sine(0.0), 0.0)
  assert_eq!(ease_out_sine(1.0), 1.0)
}

test "Ease in expo" {
  assert_eq!(ease_in_expo(0.0), 0.0)
  assert_eq!(ease_in_expo(1.0), 1.0)
}

test "Ease out expo" {
  assert_eq!(ease_out_expo(0.0), 0.0)
  assert_eq!(ease_out_expo(1.0), 1.0)
}

test "Ease in circ" {
  assert_eq!(ease_in_circ(0.0), 0.0)
  assert_eq!(ease_in_circ(1.0), 1.0)
}

test "Ease out circ" {
  assert_eq!(ease_out_circ(0.0), 0.0)
  assert_eq!(ease_out_circ(1.0), 1.0)
}

test "Ease in back" {
  assert_eq!(ease_in_back(0.0), 0.0)
  assert_eq!(ease_in_back(1.0), 1.0)
}

test "Ease out back" {
  assert_eq!(ease_out_back(0.0), 0.0)
  assert_eq!(ease_out_back(1.0), 1.0)
}

test "Ease in elastic" {
  assert_eq!(ease_in_elastic(0.0), 0.0)
  assert_eq!(ease_in_elastic(1.0), 1.0)
}

test "Ease out elastic" {
  assert_eq!(ease_out_elastic(0.0), 0.0)
  assert_eq!(ease_out_elastic(1.0), 1.0)
}

test "Ease in bounce" {
  assert_eq!(ease_in_bounce(0.0), 0.0)
  assert_eq!(ease_in_bounce(1.0), 1.0)
}

test "Ease out bounce" {
  assert_eq!(ease_out_bounce(0.0), 0.0)
  assert_eq!(ease_out_bounce(1.0), 1.0)
}

test "Cubic Bezier ease" {
  let bezier = CubicBezier::new(0.25, 0.1, 0.25, 1.0)
  assert_eq!(bezier.ease(0.0), 0.0)
  assert_eq!(bezier.ease(1.0), 1.0)
}

test "Cubic Bezier custom" {
  let bezier = CubicBezier::new(0.42, 0.0, 0.58, 1.0)
  let mid = bezier.ease(0.5)
  assert_eq!(mid > 0.4 && mid < 0.6, true)
}

test "CSS ease preset" {
  let e = ease()
  assert_eq!(e.ease(0.0), 0.0)
  assert_eq!(e.ease(1.0), 1.0)
}

test "Ease value interpolation" {
  let val = ease_value(0.0, 100.0, 0.5, linear)
  assert_eq!(val, 50.0)
}

test "Ease sequence generation" {
  let seq = ease_sequence(0.0, 100.0, 5, linear)
  assert_eq!(seq.length(), 5)
  assert_eq!(seq[0], 0.0)
  assert_eq!(seq[4], 100.0)
}

test "Reverse easing" {
  let ease_in_fn = fn(t : Double) -> Double { ease_in_quad(t) }
  let reversed = reverse_easing(ease_in_fn)
  let v1 = ease_in_fn(0.3)
  let v2 = reversed(0.7)
  assert_eq!(@math.abs(v1 + v2 - 1.0) < 0.01, true)
}

test "Mirror easing" {
  let ease_in_fn = fn(t : Double) -> Double { ease_in_cubic(t) }
  let mirrored = mirror_easing(ease_in_fn)
  assert_eq!(mirrored(0.0), 0.0)
  assert_eq!(mirrored(1.0), 1.0)
}

test "Chain easing" {
  let linear_fn = fn(t : Double) -> Double { linear(t) }
  let quad_fn = fn(t : Double) -> Double { ease_in_quad(t) }
  let chained = chain_easing(linear_fn, quad_fn, 0.5)
  assert_eq!(chained(0.0), 0.0)
  assert_eq!(chained(1.0) > 0.99, true)
}
