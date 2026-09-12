///|
test "caller supplied curve preserves endpoints" {
  let curve = fn(t : Double) -> Double { t * t }
  assert_eq(curve(0.0), 0.0)
  assert_eq(curve(1.0), 1.0)
}

///|
test "sampling and interpolation include boundary values" {
  let identity = fn(t : Double) -> Double { t }
  let normalized = sample(identity, 3)
  assert_eq(normalized.length(), 3)
  assert_eq(normalized[1], 0.5)
  let values = frames(10.0, 20.0, 3, identity)
  assert_eq(values[2], 20.0)
  assert_eq(frames(10.0, 20.0, 1, identity).length(), 1)
}

///|
test "motion diagnostics identify a caller supplied linear curve" {
  let identity = fn(t : Double) -> Double { t }
  let report = profile(identity, 32)
  assert_eq(report.monotonic, true)
  assert_eq(report.endpoint_error, 0.0)
  assert_eq((report.max_speed - 1.0).abs() < 0.01, true)
  assert_eq(is_monotonic(identity, 16), true)
  assert_eq(max_overshoot(identity, 16), 0.0)
  assert_eq((velocity(identity, 0.5, 0.001) - 1.0).abs() < 0.01, true)
}

///|
test "quality check reports a passing curve" {
  let curve = fn(t : Double) -> Double { t }
  let result = check(curve, 64, CurvePolicy::strict())
  assert_eq(result.passed, true)
  assert_eq(result.endpoints_ok, true)
  assert_eq(result.monotonic_ok, true)
  assert_eq(result.overshoot_ok, true)
}

///|
test "quality check detects overshoot and non-monotonic motion" {
  let curve = fn(t : Double) -> Double {
    if t < 0.5 {
      t * 2.4
    } else {
      1.2 - (t - 0.5) * 0.4
    }
  }
  let result = check(curve, 120, CurvePolicy::strict())
  assert_eq(result.passed, false)
  assert_eq(result.monotonic_ok, false)
  assert_eq(result.overshoot_ok, false)
}

///|
test "timeline handles invalid durations and boundaries" {
  let identity = fn(t : Double) -> Double { t }
  let timeline = MotionTimeline::new()
  timeline.append(0.0, 10.0, -1.0, identity)
  timeline.append(0.0, 10.0, 1.0, identity)
  timeline.append(10.0, 20.0, 1.0, identity)
  assert_eq(timeline.duration(), 2.0)
  assert_eq(timeline.value_at(0.5), 5.0)
  assert_eq(timeline.value_at(1.5), 15.0)
  assert_eq(timeline.frames(2).length(), 5)
}

///|
test "empty and invalid timelines are deterministic" {
  let timeline = MotionTimeline::new()
  assert_eq(timeline.duration(), 0.0)
  assert_eq(timeline.value_at(0.0), 0.0)
  assert_eq(timeline.frames(0).length(), 0)
}
