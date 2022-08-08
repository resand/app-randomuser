//
//  AnimationImageProvider.swift
//  Lottie_iOS
//
//  Created by Alexandr Goncharov on 07/06/2019.
//

import Foundation

// MARK: - AnimationTextProvider

/// Text provider is a protocol that is used to supply text to `AnimationView`.
 protocol AnimationTextProvider: AnyObject {
  func textFor(keypathName: String, sourceText: String) -> String
}

// MARK: - DictionaryTextProvider

/// Text provider that simply map values from dictionary
 final class DictionaryTextProvider: AnimationTextProvider {

  // MARK: Lifecycle

   init(_ values: [String: String]) {
    self.values = values
  }

  // MARK: 

   func textFor(keypathName: String, sourceText: String) -> String {
    values[keypathName] ?? sourceText
  }

  // MARK: Internal

  let values: [String: String]
}

// MARK: - DefaultTextProvider

/// Default text provider. Uses text in the animation file
 final class DefaultTextProvider: AnimationTextProvider {

  // MARK: Lifecycle

   init() { }

  // MARK: 

   func textFor(keypathName _: String, sourceText: String) -> String {
    sourceText
  }
}
