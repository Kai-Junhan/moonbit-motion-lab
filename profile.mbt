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
