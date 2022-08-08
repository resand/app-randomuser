//
//  Animation.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

func AnimateIn(
    duration: TimeInterval = 0.6,
    delay: TimeInterval = 0,
    _ actions: @escaping () -> Void,
    completion: ((Bool) -> Void)? = nil
) {
    AnimateIn(
        duration: duration,
        delay: delay,
        isAnimated: true,
        actions,
        completion: completion
    )
}

func AnimateIn(
    duration: TimeInterval = 0.6,
    delay: TimeInterval = 0,
    isAnimated: Bool = true,
    _ actions: @escaping () -> Void,
    completion: ((Bool) -> Void)? = nil
) {
    guard isAnimated, !UIAccessibility.isReduceMotionEnabled else {
        actions()
        completion?(true)
        return
    }

    UIView.animate(
        withDuration: duration,
        delay: delay,
        usingSpringWithDamping: 0.8,
        initialSpringVelocity: 4,
        options: .curveEaseInOut,
        animations: actions,
        completion: completion
    )
}
