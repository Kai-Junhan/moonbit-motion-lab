// Cubic Bezier easing with control points
struct CubicBezier {
  x1 : Double
  y1 : Double
  x2 : Double
  y2 : Double
}

// Create a cubic Bezier easing function
pub fn CubicBezier::new(x1 : Double, y1 : Double, x2 : Double, y2 : Double) -> CubicBezier {
  { x1, y1, x2, y2 }
}

// Evaluate cubic Bezier at time t
pub fn CubicBezier::ease(self : CubicBezier, t : Double) -> Double {
  if t <= 0.0 { return 0.0 }
  if t >= 1.0 { return 1.0 }

  // Find x that corresponds to t using Newton-Raphson
  let x = solve_bezier_x(t, self.x1, self.x2)

  // Calculate y at that x
  bezier_y(x, self.y1, self.y2)
}

fn solve_bezier_x(t : Double, x1 : Double, x2 : Double) -> Double {
  let mut x = t
  let epsilon = 0.0001

  for _ = 0; _ < 10; _ = _ + 1 {
    let current_t = bezier_x(x, x1, x2)
    let diff = current_t - t
    if @math.abs(diff) < epsilon {
      return x
    }
    let derivative = bezier_x_derivative(x, x1, x2)
    if @math.abs(derivative) < epsilon {
      break
    }
    x = x - diff / derivative
  }

  x
}

fn bezier_x(t : Double, x1 : Double, x2 : Double) -> Double {
  let t2 = t * t
  let t3 = t2 * t
  let mt = 1.0 - t
  let mt2 = mt * mt
  3.0 * mt2 * t * x1 + 3.0 * mt * t2 * x2 + t3
}

fn bezier_x_derivative(t : Double, x1 : Double, x2 : Double) -> Double {
  let t2 = t * t
  let mt = 1.0 - t
  let mt2 = mt * mt
  3.0 * mt2 * x1 + 6.0 * mt * t * (x2 - x1) + 3.0 * t2 * (1.0 - x2)
}

fn bezier_y(t : Double, y1 : Double, y2 : Double) -> Double {
  let t2 = t * t
  let t3 = t2 * t
  let mt = 1.0 - t
  let mt2 = mt * mt
  3.0 * mt2 * t * y1 + 3.0 * mt * t2 * y2 + t3
}

// Common CSS cubic-bezier presets
pub fn ease() -> CubicBezier {
  CubicBezier::new(0.25, 0.1, 0.25, 1.0)
}

pub fn ease_in() -> CubicBezier {
  CubicBezier::new(0.42, 0.0, 1.0, 1.0)
}

pub fn ease_out() -> CubicBezier {
  CubicBezier::new(0.0, 0.0, 0.58, 1.0)
}

pub fn ease_in_out() -> CubicBezier {
  CubicBezier::new(0.42, 0.0, 0.58, 1.0)
}
