///|
/// A normalized motion curve supplied by the caller.
///
/// Motion Lab does not provide a catalogue of easing equations. An application
/// or another package can pass any function mapping normalized progress to a
/// value for sampling, profiling, and timeline compilation.
pub type MotionFn = (Double) -> Double
