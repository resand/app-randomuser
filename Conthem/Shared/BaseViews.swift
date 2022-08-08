//
//  BaseViews.swift
//  Conthem
//
//  Created by René Sandoval on 06/08/22.
//

import Foundation
import UIKit

protocol Customizable {
    func setup()
    func setupAppearance()
    func setupLayout()
    func updateContent()
}

class BaseView: UIView, Customizable {
    fileprivate var isInitialized: Bool = false
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard !isInitialized, superview != nil else { return }

        isInitialized = true

        setup()
        setupLayout()
        setupAppearance()
        updateContent()
    }

    open func setup() {}
    open func setupAppearance() { setNeedsLayout() }
    open func setupLayout() { setNeedsLayout() }
    open func updateContent() { setNeedsLayout() }
}
