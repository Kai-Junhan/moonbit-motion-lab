// Linear easing (no acceleration)
pub fn linear(t : Double) -> Double {
  t
}

// Quadratic easing functions
pub fn ease_in_quad(t : Double) -> Double {
  t * t
}

pub fn ease_out_quad(t : Double) -> Double {
  t * (2.0 - t)
}

pub fn ease_in_out_quad(t : Double) -> Double {
  if t < 0.5 {
    2.0 * t * t
  } else {
    -1.0 + (4.0 - 2.0 * t) * t
  }
}

// Cubic easing functions
pub fn ease_in_cubic(t : Double) -> Double {
  t * t * t
}

pub fn ease_out_cubic(t : Double) -> Double {
  let t1 = t - 1.0
  t1 * t1 * t1 + 1.0
}

pub fn ease_in_out_cubic(t : Double) -> Double {
  if t < 0.5 {
    4.0 * t * t * t
  } else {
    let t1 = 2.0 * t - 2.0
    1.0 + t1 * t1 * t1 / 2.0
  }
}

// Quartic easing functions
pub fn ease_in_quart(t : Double) -> Double {
  t * t * t * t
}

pub fn ease_out_quart(t : Double) -> Double {
  let t1 = t - 1.0
  1.0 - t1 * t1 * t1 * t1
}

pub fn ease_in_out_quart(t : Double) -> Double {
  if t < 0.5 {
    8.0 * t * t * t * t
  } else {
    let t1 = t - 1.0
    1.0 - 8.0 * t1 * t1 * t1 * t1
  }
}

// Quintic easing functions
pub fn ease_in_quint(t : Double) -> Double {
  t * t * t * t * t
}

pub fn ease_out_quint(t : Double) -> Double {
  let t1 = t - 1.0
  1.0 + t1 * t1 * t1 * t1 * t1
}

pub fn ease_in_out_quint(t : Double) -> Double {
  if t < 0.5 {
    16.0 * t * t * t * t * t
  } else {
    let t1 = 2.0 * t - 2.0
    1.0 + t1 * t1 * t1 * t1 * t1 / 2.0
  }
}

// Sine easing functions
pub fn ease_in_sine(t : Double) -> Double {
  1.0 - @math.cos(t * @math.pi / 2.0)
}

pub fn ease_out_sine(t : Double) -> Double {
  @math.sin(t * @math.pi / 2.0)
}

pub fn ease_in_out_sine(t : Double) -> Double {
  -((@math.cos(@math.pi * t) - 1.0) / 2.0)
}

// Exponential easing functions
pub fn ease_in_expo(t : Double) -> Double {
  if t == 0.0 {
    0.0
  } else {
    @math.pow(2.0, 10.0 * t - 10.0)
  }
}

pub fn ease_out_expo(t : Double) -> Double {
  if t == 1.0 {
    1.0
  } else {
    1.0 - @math.pow(2.0, -10.0 * t)
  }
}

pub fn ease_in_out_expo(t : Double) -> Double {
  if t == 0.0 {
    return 0.0
  }
  if t == 1.0 {
    return 1.0
  }
  if t < 0.5 {
    @math.pow(2.0, 20.0 * t - 10.0) / 2.0
  } else {
    (2.0 - @math.pow(2.0, -20.0 * t + 10.0)) / 2.0
  }
}

// Circular easing functions
pub fn ease_in_circ(t : Double) -> Double {
  1.0 - @math.sqrt(1.0 - t * t)
}

pub fn ease_out_circ(t : Double) -> Double {
  @math.sqrt(1.0 - (t - 1.0) * (t - 1.0))
}

pub fn ease_in_out_circ(t : Double) -> Double {
  if t < 0.5 {
    (1.0 - @math.sqrt(1.0 - 4.0 * t * t)) / 2.0
  } else {
    let t1 = -2.0 * t + 2.0
    (@math.sqrt(1.0 - t1 * t1) + 1.0) / 2.0
  }
}

// Back easing functions (overshooting)
pub fn ease_in_back(t : Double) -> Double {
  let c1 = 1.70158
  let c3 = c1 + 1.0
  c3 * t * t * t - c1 * t * t
}

pub fn ease_out_back(t : Double) -> Double {
  let c1 = 1.70158
  let c3 = c1 + 1.0
  let t1 = t - 1.0
  1.0 + c3 * t1 * t1 * t1 + c1 * t1 * t1
}

pub fn ease_in_out_back(t : Double) -> Double {
  let c1 = 1.70158
  let c2 = c1 * 1.525
  if t < 0.5 {
    let t2 = 2.0 * t
    (t2 * t2 * ((c2 + 1.0) * 2.0 * t - c2)) / 2.0
  } else {
    let t2 = 2.0 * t - 2.0
    (t2 * t2 * ((c2 + 1.0) * t2 + c2) + 2.0) / 2.0
  }
}
