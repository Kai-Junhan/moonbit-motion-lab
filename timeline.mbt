///|
/// One value transition in a sequential motion timeline.
pub struct MotionSegment {
  start : Double
  end : Double
  duration : Double
  motion : MotionFn
}

///|
/// A deterministic, renderer-independent sequence of motion segments.
pub struct MotionTimeline {
  segments : Array[MotionSegment]
}

///|
/// Create an empty motion timeline.
pub fn MotionTimeline::new() -> MotionTimeline {
  { segments: Array::new() }
}

///|
/// Add a segment. Non-positive durations are ignored during playback.
pub fn MotionTimeline::append(
  self : MotionTimeline,
  start : Double,
  end : Double,
  duration : Double,
  motion : MotionFn,
) -> Unit {
  self.segments.push({ start, end, duration, motion })
}

///|
/// Sum the usable durations in this timeline.
pub fn MotionTimeline::duration(self : MotionTimeline) -> Double {
  let mut total = 0.0
  for segment in self.segments {
    if segment.duration > 0.0 {
      total = total + segment.duration
    }
  }
  total
}

///|
/// Evaluate the timeline at elapsed time. An empty timeline evaluates to zero.
pub fn MotionTimeline::value_at(self : MotionTimeline, time : Double) -> Double {
  let mut elapsed = 0.0
  let mut last = 0.0
  for segment in self.segments {
    last = segment.end
    if segment.duration <= 0.0 {
      continue
    }
    if time <= elapsed + segment.duration {
      return interpolate(
        segment.start,
        segment.end,
        clamp01((time - elapsed) / segment.duration),
        segment.motion,
      )
    }
    elapsed = elapsed + segment.duration
  }
  last
}

///|
/// Produce timeline values at a fixed frame rate.
pub fn MotionTimeline::frames(
  self : MotionTimeline,
  fps : Int,
) -> Array[Double] {
  let result : Array[Double] = Array::new()
  if fps <= 0 {
    return result
  }
  let count = (self.duration() * fps.to_double()).to_int() + 1
  for i in 0..<count {
    result.push(self.value_at(i.to_double() / fps.to_double()))
  }
  result
}
