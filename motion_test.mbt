///|
test "parameterized curves preserve endpoints" {
  assert_eq(back_in(0.0, 1.7), 0.0)
  assert_eq(back_out(1.0, 1.7), 1.0)
  assert_eq(spring_out(0.0, 4.0, 2.0), 0.0)
  assert_eq(spring_out(1.0, 4.0, 2.0), 1.0)
}

///|
test "custom bezier evaluates endpoints and midpoint" {
  let curve = CubicBezier::new(0.17, 0.67, 0.83, 0.67)
  assert_eq(curve.value_at(0.0), 0.0)
  assert_eq(curve.value_at(1.0), 1.0)
  assert_eq(curve.value_at(0.5) > 0.6, true)
}

///|
test "sampling and interpolation include boundary values" {
  let normalized = sample(linear, 3)
  assert_eq(normalized.length(), 3)
  assert_eq(normalized[1], 0.5)
  let values = frames(10.0, 20.0, 3, linear)
  assert_eq(values[2], 20.0)
  assert_eq(frames(10.0, 20.0, 1, linear).length(), 1)
}

///|
test "motion diagnostics identify linear curve" {
  let report = profile(linear, 32)
  assert_eq(report.monotonic, true)
  assert_eq(report.endpoint_error, 0.0)
  assert_eq((report.max_speed - 1.0).abs() < 0.01, true)
  assert_eq(is_monotonic(linear, 16), true)
  assert_eq(max_overshoot(linear, 16), 0.0)
  assert_eq((velocity(linear, 0.5, 0.001) - 1.0).abs() < 0.01, true)
}

///|
test "motion report detects spring overshoot" {
  let spring = fn(t : Double) -> Double { spring_out(t, 4.0, 2.0) }
  let report = profile(spring, 120)
  assert_eq(report.max_value > 1.0, true)
  assert_eq(report.monotonic, false)
}

///|
test "timeline compiles sequential motion" {
  let timeline = MotionTimeline::new()
  timeline.append(0.0, 10.0, 1.0, linear)
  timeline.append(10.0, 20.0, 1.0, linear)
  assert_eq(timeline.duration(), 2.0)
  assert_eq(timeline.value_at(0.5), 5.0)
  assert_eq(timeline.value_at(1.5), 15.0)
  assert_eq(timeline.frames(2).length(), 5)
}
