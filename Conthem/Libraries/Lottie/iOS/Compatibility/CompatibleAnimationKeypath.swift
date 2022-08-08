//
//  CompatibleAnimationKeypath.swift
//  Lottie_iOS
//
//  Created by Tyler Hedrick on 3/6/19.
//

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)

/// An Objective-C compatible wrapper around Lottie's AnimationKeypath
@objc
 final class CompatibleAnimationKeypath: NSObject {

  // MARK: Lifecycle

  /// Creates a keypath from a dot separated string. The string is separated by "."
  @objc
   init(keypath: String) {
    animationKeypath = AnimationKeypath(keypath: keypath)
  }

  /// Creates a keypath from a list of strings.
  @objc
   init(keys: [String]) {
    animationKeypath = AnimationKeypath(keys: keys)
  }

  // MARK: 

   let animationKeypath: AnimationKeypath
}
#endif
