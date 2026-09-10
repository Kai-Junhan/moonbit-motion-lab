///|
/// Clamp a value to the normalized animation interval.
pub fn clamp01(value : Double) -> Double {
  if value < 0.0 {
    0.0
  } else if value > 1.0 {
    1.0
  } else {
    value
  }
}

///|
/// Map normalized motion progress onto an application value range.
pub fn interpolate(
  start : Double,
  end : Double,
  t : Double,
  motion : MotionFn,
) -> Double {
  start + (end - start) * motion(t)
}

///|
/// Sample a motion curve at evenly spaced points, including both endpoints.
pub fn sample(motion : MotionFn, count : Int) -> Array[Double] {
  let result : Array[Double] = Array::new()
  if count <= 0 {
    return result
  }
  if count == 1 {
    result.push(motion(0.0))
    return result
  }
  for i in 0..<count {
    result.push(motion(i.to_double() / (count - 1).to_double()))
  }
  result
}

///|
/// Generate interpolated application values from a motion curve.
pub fn frames(
  start : Double,
  end : Double,
  count : Int,
  motion : MotionFn,
) -> Array[Double] {
  let result : Array[Double] = Array::new()
  if count <= 0 {
    return result
  }
  if count == 1 {
    result.push(start)
    return result
  }
  for i in 0..<count {
    let t = i.to_double() / (count - 1).to_double()
    result.push(interpolate(start, end, t, motion))
  }
  result
}

///|
/// Join two normalized motions at `split`.
pub fn stitch(first : MotionFn, second : MotionFn, split : Double) -> MotionFn {
  fn(t : Double) -> Double {
    if split <= 0.0 {
      second(t)
    } else if split >= 1.0 {
      first(t)
    } else if t < split {
      first(t / split) * split
    } else {
      split + second((t - split) / (1.0 - split)) * (1.0 - split)
    }
  }
}

///|
/// Estimate local velocity with a centered finite difference.
pub fn velocity(motion : MotionFn, t : Double, epsilon : Double) -> Double {
  let step = if epsilon <= 0.0 { 0.000001 } else { epsilon }
  (motion(t + step) - motion(t - step)) / (2.0 * step)
}

///|
/// Check whether sampled values never decrease.
pub fn is_monotonic(motion : MotionFn, samples : Int) -> Bool {
  let values = sample(motion, samples)
  for i in 1..<values.length() {
    if values[i] < values[i - 1] {
      return false
    }
  }
  true
}

///|
/// Return the largest amount by which a curve exceeds `[0, 1]`.
pub fn max_overshoot(motion : MotionFn, samples : Int) -> Double {
  let mut largest = 0.0
  for value in sample(motion, samples) {
    let excess = if value < 0.0 {
      -value
    } else if value > 1.0 {
      value - 1.0
    } else {
      0.0
    }
    if excess > largest {
      largest = excess
    }
  }
  largest
}
