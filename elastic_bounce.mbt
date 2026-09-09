// Elastic easing functions (spring-like)
pub fn ease_in_elastic(t : Double) -> Double {
  let c4 = (2.0 * @math.pi) / 3.0
  if t == 0.0 {
    return 0.0
  }
  if t == 1.0 {
    return 1.0
  }
  -@math.pow(2.0, 10.0 * t - 10.0) * @math.sin((t * 10.0 - 10.75) * c4)
}

pub fn ease_out_elastic(t : Double) -> Double {
  let c4 = (2.0 * @math.pi) / 3.0
  if t == 0.0 {
    return 0.0
  }
  if t == 1.0 {
    return 1.0
  }
  @math.pow(2.0, -10.0 * t) * @math.sin((t * 10.0 - 0.75) * c4) + 1.0
}

pub fn ease_in_out_elastic(t : Double) -> Double {
  let c5 = (2.0 * @math.pi) / 4.5
  if t == 0.0 {
    return 0.0
  }
  if t == 1.0 {
    return 1.0
  }
  if t < 0.5 {
    -(@math.pow(2.0, 20.0 * t - 10.0) * @math.sin((20.0 * t - 11.125) * c5)) / 2.0
  } else {
    (@math.pow(2.0, -20.0 * t + 10.0) * @math.sin((20.0 * t - 11.125) * c5)) / 2.0 + 1.0
  }
}

// Bounce easing functions
pub fn ease_out_bounce(t : Double) -> Double {
  let n1 = 7.5625
  let d1 = 2.75

  if t < 1.0 / d1 {
    n1 * t * t
  } else if t < 2.0 / d1 {
    let t2 = t - 1.5 / d1
    n1 * t2 * t2 + 0.75
  } else if t < 2.5 / d1 {
    let t2 = t - 2.25 / d1
    n1 * t2 * t2 + 0.9375
  } else {
    let t2 = t - 2.625 / d1
    n1 * t2 * t2 + 0.984375
  }
}

pub fn ease_in_bounce(t : Double) -> Double {
  1.0 - ease_out_bounce(1.0 - t)
}

pub fn ease_in_out_bounce(t : Double) -> Double {
  if t < 0.5 {
    (1.0 - ease_out_bounce(1.0 - 2.0 * t)) / 2.0
  } else {
    (1.0 + ease_out_bounce(2.0 * t - 1.0)) / 2.0
  }
}
