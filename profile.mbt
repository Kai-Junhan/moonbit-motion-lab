///|
/// Numerical summary of a normalized motion curve.
pub struct CurveReport {
  min_value : Double
  max_value : Double
  max_speed : Double
  time_of_max_speed : Double
  monotonic : Bool
  endpoint_error : Double
}

///|
/// Acceptance limits for a motion curve.
///
/// A negative `max_speed` disables the speed limit. `max_overshoot` is the
/// largest permitted distance outside the normalized `[0, 1]` range.
pub struct CurvePolicy {
  endpoint_tolerance : Double
  require_monotonic : Bool
  max_overshoot : Double
  max_speed : Double
}

///|
/// A practical default for curves that must stay in range and finish exactly.
pub fn CurvePolicy::strict() -> CurvePolicy {
  {
    endpoint_tolerance: 0.000001,
    require_monotonic: true,
    max_overshoot: 0.0,
    max_speed: -1.0,
  }
}

///|
/// Deterministic result of checking a curve against a `CurvePolicy`.
pub struct CurveCheck {
  report : CurveReport
  overshoot : Double
  endpoints_ok : Bool
  monotonic_ok : Bool
  overshoot_ok : Bool
  speed_ok : Bool
  passed : Bool
}

///|
/// Profile a curve using a deterministic number of samples.
pub fn profile(motion : MotionFn, samples : Int) -> CurveReport {
  let count = if samples < 2 { 2 } else { samples }
  let mut min_value = motion(0.0)
  let mut max_value = min_value
  let mut max_speed = 0.0
  let mut time_of_max_speed = 0.0
  let mut monotonic = true
  let mut previous = min_value
  for i in 1..<count {
    let t = i.to_double() / (count - 1).to_double()
    let value = motion(t)
    if value < min_value {
      min_value = value
    }
    if value > max_value {
      max_value = value
    }
    if value < previous {
      monotonic = false
    }
    let speed = ((value - previous) * (count - 1).to_double()).abs()
    if speed > max_speed {
      max_speed = speed
      time_of_max_speed = t
    }
    previous = value
  }
  {
    min_value,
    max_value,
    max_speed,
    time_of_max_speed,
    monotonic,
    endpoint_error: motion(0.0).abs() + (motion(1.0) - 1.0).abs(),
  }
}

///|
/// Check a curve against explicit product requirements.
pub fn check(
  motion : MotionFn,
  samples : Int,
  policy : CurvePolicy,
) -> CurveCheck {
  let report = profile(motion, samples)
  let overshoot = max_overshoot(motion, samples)
  let tolerance = if policy.endpoint_tolerance < 0.0 {
    0.0
  } else {
    policy.endpoint_tolerance
  }
  let endpoints_ok = report.endpoint_error <= tolerance
  let monotonic_ok = !policy.require_monotonic || report.monotonic
  let overshoot_ok = overshoot <= policy.max_overshoot
  let speed_ok = policy.max_speed < 0.0 || report.max_speed <= policy.max_speed
  {
    report,
    overshoot,
    endpoints_ok,
    monotonic_ok,
    overshoot_ok,
    speed_ok,
    passed: endpoints_ok && monotonic_ok && overshoot_ok && speed_ok,
  }
}
