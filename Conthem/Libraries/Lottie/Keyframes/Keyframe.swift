// Created by Cal Stephens on 1/24/22.
// Copyright © 2022 Airbnb Inc. All rights reserved.

// MARK: - Keyframe

/// A keyframe with a single value, and timing information
/// about when the value should be displayed and how it
/// should be interpolated.
 final class Keyframe<T> {

  // MARK: Lifecycle

  /// Initialize a value-only keyframe with no time data.
   init(
    _ value: T,
    spatialInTangent: Vector3D? = nil,
    spatialOutTangent: Vector3D? = nil)
  {
    self.value = value
    time = 0
    isHold = true
    inTangent = nil
    outTangent = nil
    self.spatialInTangent = spatialInTangent
    self.spatialOutTangent = spatialOutTangent
  }

  /// Initialize a keyframe
   init(
    value: T,
    time: AnimationFrameTime,
    isHold: Bool = false,
    inTangent: Vector2D? = nil,
    outTangent: Vector2D? = nil,
    spatialInTangent: Vector3D? = nil,
    spatialOutTangent: Vector3D? = nil)
  {
    self.value = value
    self.time = time
    self.isHold = isHold
    self.outTangent = outTangent
    self.inTangent = inTangent
    self.spatialInTangent = spatialInTangent
    self.spatialOutTangent = spatialOutTangent
  }

  // MARK: 

  /// The value of the keyframe
   let value: T
  /// The time in frames of the keyframe.
   let time: AnimationFrameTime
  /// A hold keyframe freezes interpolation until the next keyframe that is not a hold.
   let isHold: Bool
  /// The in tangent for the time interpolation curve.
   let inTangent: Vector2D?
  /// The out tangent for the time interpolation curve.
   let outTangent: Vector2D?

  /// The spatial in tangent of the vector.
   let spatialInTangent: Vector3D?
  /// The spatial out tangent of the vector.
   let spatialOutTangent: Vector3D?
}

// MARK: Equatable

extension Keyframe: Equatable where T: Equatable {
   static func == (lhs: Keyframe<T>, rhs: Keyframe<T>) -> Bool {
    lhs.value == rhs.value
      && lhs.time == rhs.time
      && lhs.isHold == rhs.isHold
      && lhs.inTangent == rhs.inTangent
      && lhs.outTangent == rhs.outTangent
      && lhs.spatialInTangent == rhs.spatialOutTangent
      && lhs.spatialOutTangent == rhs.spatialOutTangent
  }
}

// MARK: Hashable

extension Keyframe: Hashable where T: Hashable {
   func hash(into hasher: inout Hasher) {
    hasher.combine(value)
    hasher.combine(time)
    hasher.combine(isHold)
    hasher.combine(inTangent)
    hasher.combine(outTangent)
    hasher.combine(spatialInTangent)
    hasher.combine(spatialOutTangent)
  }
}
