//
//  LRUAnimationCache.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/5/19.
//

import Foundation

/// An Animation Cache that will store animations up to `cacheSize`.
///
/// Once `cacheSize` is reached, the least recently used animation will be ejected.
/// The default size of the cache is 100.
 class LRUAnimationCache: AnimationCacheProvider {

  // MARK: Lifecycle

   init() { }

  // MARK: 

  /// The global shared Cache.
   static let sharedCache = LRUAnimationCache()

  /// The size of the cache.
   var cacheSize = 100

  /// Clears the Cache.
   func clearCache() {
    cacheMap.removeAll()
    lruList.removeAll()
  }

   func animation(forKey: String) -> Animation? {
    guard let animation = cacheMap[forKey] else {
      return nil
    }
    if let index = lruList.firstIndex(of: forKey) {
      lruList.remove(at: index)
      lruList.append(forKey)
    }
    return animation
  }

   func setAnimation(_ animation: Animation, forKey: String) {
    cacheMap[forKey] = animation
    lruList.append(forKey)
    if lruList.count > cacheSize {
      let removed = lruList.remove(at: 0)
      if removed != forKey {
        cacheMap[removed] = nil
      }
    }
  }

  // MARK: Fileprivate

  fileprivate var cacheMap: [String: Animation] = [:]
  fileprivate var lruList: [String] = []

}
