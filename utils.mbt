// Easing function type
type EasingFn (Double) -> Double

// Apply easing to interpolate between two values
pub fn ease_value(start : Double, end : Double, t : Double, easing : EasingFn) -> Double {
  start + (end - start) * easing(t)
}

// Generate a sequence of eased values
pub fn ease_sequence(start : Double, end : Double, steps : Int, easing : EasingFn) -> Array[Double] {
  let result = Array::new()
  for i = 0; i < steps; i = i + 1 {
    let t = i.to_double() / (steps - 1).to_double()
    result.push(ease_value(start, end, t, easing))
  }
  result
}

// Chain two easing functions
pub fn chain_easing(first : EasingFn, second : EasingFn, split : Double) -> EasingFn {
  fn(t : Double) -> Double {
    if t < split {
      first(t / split) * split
    } else {
      split + second((t - split) / (1.0 - split)) * (1.0 - split)
    }
  }
}

// Reverse an easing function
pub fn reverse_easing(easing : EasingFn) -> EasingFn {
  fn(t : Double) -> Double {
    1.0 - easing(1.0 - t)
  }
}

// Mirror an easing function (ease in-out style)
pub fn mirror_easing(easing : EasingFn) -> EasingFn {
  fn(t : Double) -> Double {
    if t < 0.5 {
      easing(t * 2.0) / 2.0
    } else {
      1.0 - easing((1.0 - t) * 2.0) / 2.0
    }
  }
}

// Clamp easing output to [0, 1] range
pub fn clamp_easing(easing : EasingFn) -> EasingFn {
  fn(t : Double) -> Double {
    let v = easing(t)
    if v < 0.0 { 0.0 }
    else if v > 1.0 { 1.0 }
    else { v }
  }
}
