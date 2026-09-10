///|
/// A normalized motion curve maps progress in `[0, 1]` to a value.
pub type MotionFn = (Double) -> Double

///|
/// The identity curve, useful as a baseline in diagnostics and timelines.
pub fn linear(t : Double) -> Double {
  t
}

///|
/// A tunable anticipation curve. `overshoot` controls how far it pulls back.
pub fn back_in(t : Double, overshoot : Double) -> Double {
  if t <= 0.0 {
    0.0
  } else if t >= 1.0 {
    1.0
  } else {
    let c3 = overshoot + 1.0
    c3 * t * t * t - overshoot * t * t
  }
}

///|
/// A tunable settling curve. `overshoot` controls how far it exceeds the end.
pub fn back_out(t : Double, overshoot : Double) -> Double {
  if t <= 0.0 {
    0.0
  } else if t >= 1.0 {
    1.0
  } else {
    let t1 = t - 1.0
    1.0 + (overshoot + 1.0) * t1 * t1 * t1 + overshoot * t1 * t1
  }
}

///|
/// A damped oscillation. `frequency` and `damping` are explicit tuning inputs.
pub fn spring_out(t : Double, frequency : Double, damping : Double) -> Double {
  if t <= 0.0 {
    return 0.0
  }
  if t >= 1.0 {
    return 1.0
  }
  let safe_frequency = if frequency <= 0.0 { 1.0 } else { frequency }
  let safe_damping = if damping < 0.0 { 0.0 } else { damping }
  let decay = @math.pow(2.718281828, -safe_damping * t)
  1.0 - decay * @math.cos(2.0 * @math.PI * safe_frequency * t)
}
