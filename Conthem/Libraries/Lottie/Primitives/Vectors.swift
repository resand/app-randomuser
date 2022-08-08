//
//  Vectors.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/4/19.
//

import Foundation

// MARK: - Vector1D

 struct Vector1D: Hashable {

   init(_ value: Double) {
    self.value = value
  }

   let value: Double

}

// MARK: - Vector3D

/// A three dimensional vector.
/// These vectors are encoded and decoded from [Double]
 struct Vector3D: Hashable {

   let x: Double
   let y: Double
   let z: Double

   init(x: Double, y: Double, z: Double) {
    self.x = x
    self.y = y
    self.z = z
  }

}
