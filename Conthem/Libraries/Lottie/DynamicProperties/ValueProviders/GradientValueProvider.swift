//
//  GradientValueProvider.swift
//  lottie-swift
//
//  Created by Enrique Bermúdez on 10/27/19.
//

import CoreGraphics
import Foundation

/// A `ValueProvider` that returns a Gradient Color Value.
 final class GradientValueProvider: ValueProvider {

  // MARK: Lifecycle

  /// Initializes with a block provider.
   init(
    block: @escaping ColorsValueBlock,
    locations: ColorLocationsBlock? = nil)
  {
    self.block = block
    locationsBlock = locations
    colors = []
    self.locations = []
  }

  /// Initializes with an array of colors.
   init(
    _ colors: [Color],
    locations: [Double] = [])
  {
    self.colors = colors
    self.locations = locations
    updateValueArray()
    hasUpdate = true
  }

  // MARK: 

  /// Returns a [Color] for a CGFloat(Frame Time).
   typealias ColorsValueBlock = (CGFloat) -> [Color]
  /// Returns a [Double](Color locations) for a CGFloat(Frame Time).
   typealias ColorLocationsBlock = (CGFloat) -> [Double]

  /// The colors values of the provider.
   var colors: [Color] {
    didSet {
      updateValueArray()
      hasUpdate = true
    }
  }

  /// The color location values of the provider.
   var locations: [Double] {
    didSet {
      updateValueArray()
      hasUpdate = true
    }
  }

  // MARK: ValueProvider Protocol

   var valueType: Any.Type {
    [Double].self
  }

   var storage: ValueProviderStorage<[Double]> {
    .closure { [self] frame in
      hasUpdate = false

      if let block = block {
        let newColors = block(frame)
        let newLocations = locationsBlock?(frame) ?? []
        value = value(from: newColors, locations: newLocations)
      }

      return value
    }
  }

   func hasUpdate(frame _: CGFloat) -> Bool {
    if block != nil || locationsBlock != nil {
      return true
    }
    return hasUpdate
  }

  // MARK: Private

  private var hasUpdate = true

  private var block: ColorsValueBlock?
  private var locationsBlock: ColorLocationsBlock?
  private var value: [Double] = []

  private func value(from colors: [Color], locations: [Double]) -> [Double] {
    var colorValues = [Double]()
    var alphaValues = [Double]()
    var shouldAddAlphaValues = false

    for i in 0..<colors.count {
      if colors[i].a < 1 { shouldAddAlphaValues = true }

      let location = locations.count > i
        ? locations[i]
        : (Double(i) / Double(colors.count - 1))

      colorValues.append(location)
      colorValues.append(colors[i].r)
      colorValues.append(colors[i].g)
      colorValues.append(colors[i].b)

      alphaValues.append(location)
      alphaValues.append(colors[i].a)
    }

    return colorValues + (shouldAddAlphaValues ? alphaValues : [])
  }

  private func updateValueArray() {
    value = value(from: colors, locations: locations)
  }
}
