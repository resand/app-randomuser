//
//  SizeValueProvider.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/4/19.
//

import CoreGraphics
import Foundation

/// A `ValueProvider` that returns a CGSize Value
 final class SizeValueProvider: ValueProvider {

  // MARK: Lifecycle

  /// Initializes with a block provider
   init(block: @escaping SizeValueBlock) {
    self.block = block
    size = .zero
  }

  /// Initializes with a single size.
   init(_ size: CGSize) {
    self.size = size
    block = nil
    hasUpdate = true
  }

  // MARK: 

  /// Returns a CGSize for a CGFloat(Frame Time)
   typealias SizeValueBlock = (CGFloat) -> CGSize

   var size: CGSize {
    didSet {
      hasUpdate = true
    }
  }

  // MARK: ValueProvider Protocol

   var valueType: Any.Type {
    Vector3D.self
  }

   var storage: ValueProviderStorage<Vector3D> {
    if let block = block {
      return .closure { frame in
        self.hasUpdate = false
        return block(frame).vector3dValue
      }
    } else {
      hasUpdate = false
      return .singleValue(size.vector3dValue)
    }
  }

   func hasUpdate(frame _: CGFloat) -> Bool {
    if block != nil {
      return true
    }
    return hasUpdate
  }

  // MARK: Private

  private var hasUpdate = true

  private var block: SizeValueBlock?
}
