///|
fn main {
  println("=== MoonBit Motion Lab Demo ===\n")
  let spring = fn(t : Double) -> Double { @motion.spring_out(t, 4.0, 2.0) }
  let report = @motion.profile(spring, 120)
  println("Spring max value: " + report.max_value.to_string())
  println("Spring peak speed: " + report.max_speed.to_string())
  println("Spring monotonic: " + report.monotonic.to_string())
  let timeline = @motion.MotionTimeline::new()
  timeline.append(0.0, 100.0, 0.6, spring)
  timeline.append(100.0, 160.0, 0.4, @motion.linear)
  let frames = timeline.frames(10)
  println("Timeline duration: " + timeline.duration().to_string())
  println("Compiled frames: " + frames.length().to_string())
  println("Final value: " + frames[frames.length() - 1].to_string())
  let bezier = @motion.CubicBezier::new(0.17, 0.67, 0.83, 0.67)
  println("Custom Bezier at 0.5: " + bezier.value_at(0.5).to_string())
}
