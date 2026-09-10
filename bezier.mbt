// Cubic Bezier easing with control points

///|
pub struct CubicBezier {
  x1 : Double
  y1 : Double
  x2 : Double
  y2 : Double
}

// Create a cubic Bezier easing function

///|
pub fn CubicBezier::new(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> CubicBezier {
  { x1, y1, x2, y2 }
}

// Evaluate a custom cubic Bezier motion curve at time t.

///|
pub fn CubicBezier::value_at(self : CubicBezier, t : Double) -> Double {
  if t <= 0.0 {
    return 0.0
  }
  if t >= 1.0 {
    return 1.0
  }

  // Find x that corresponds to t using Newton-Raphson
  let x = solve_bezier_x(t, self.x1, self.x2)

  // Calculate y at that x
  bezier_y(x, self.y1, self.y2)
}

///|
fn solve_bezier_x(t : Double, x1 : Double, x2 : Double) -> Double {
  let mut x = t
  let epsilon = 0.0001

  for _ in 0..<10 {
    let current_t = bezier_x(x, x1, x2)
    let diff = current_t - t
    if diff.abs() < epsilon {
      return x
    }
    let derivative = bezier_x_derivative(x, x1, x2)
    if derivative.abs() < epsilon {
      break
    }
    x = x - diff / derivative
  }

  x
}

///|
fn bezier_x(t : Double, x1 : Double, x2 : Double) -> Double {
  let t2 = t * t
  let t3 = t2 * t
  let mt = 1.0 - t
  let mt2 = mt * mt
  3.0 * mt2 * t * x1 + 3.0 * mt * t2 * x2 + t3
}

///|
fn bezier_x_derivative(t : Double, x1 : Double, x2 : Double) -> Double {
  let t2 = t * t
  let mt = 1.0 - t
  let mt2 = mt * mt
  3.0 * mt2 * x1 + 6.0 * mt * t * (x2 - x1) + 3.0 * t2 * (1.0 - x2)
}

///|
fn bezier_y(t : Double, y1 : Double, y2 : Double) -> Double {
  let t2 = t * t
  let t3 = t2 * t
  let mt = 1.0 - t
  let mt2 = mt * mt
  3.0 * mt2 * t * y1 + 3.0 * mt * t2 * y2 + t3
}
