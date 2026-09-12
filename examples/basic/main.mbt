///|
fn main {
  println("=== MoonBit Motion Lab Demo ===\n")

  // This curve belongs to the application (or can come from an easing package).
  let product_curve = fn(t : Double) -> Double { t * t * (3.0 - 2.0 * t) }
  let report = @motion.profile(product_curve, 120)
  let policy = @motion.CurvePolicy::strict()
  let check = @motion.check(product_curve, 120, policy)
  println("Curve max speed: " + report.max_speed.to_string())
  println("Curve accepted: " + check.passed.to_string())

  let timeline = @motion.MotionTimeline::new()
  timeline.append(0.0, 100.0, 0.6, product_curve)
  timeline.append(100.0, 160.0, 0.4, product_curve)
  let compiled_frames = timeline.frames(10)
  println("Timeline duration: " + timeline.duration().to_string())
  println("Compiled frames: " + compiled_frames.length().to_string())
  println(
    "Final value: " + compiled_frames[compiled_frames.length() - 1].to_string(),
  )

  let overshooting_curve = fn(t : Double) -> Double {
    if t < 0.5 {
      t * 2.4
    } else {
      1.2 - (t - 0.5) * 0.4
    }
  }
  let rejected = @motion.check(overshooting_curve, 120, policy)
  println("Overshooting curve accepted: " + rejected.passed.to_string())
}
