//
//  UIView+Extensions.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit.NSLayoutConstraint

extension UIView {
    // MARK: - Safe anchors

    /// Contains view's top anchor depending to iOS version.
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    /// Contains view's leading anchor depending to iOS version.
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }

    /// Contains view's trailing anchor depending to iOS version.
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }

    /// Contains view's bottom anchor depending to iOS version.
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

    // MARK: - Common constraints

    /// Adds a constraint (top) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (bottom) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (leading) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (trailing) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    // MARK: - Height constraints

    /// Adds a height constraint with constant value.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func heightAnchor(equalTo constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (height) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - multiplier: The multiplier constant for the constraint.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }

    // MARK: - Width constraints

    /// Adds a width constraint with constant value.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(equalTo constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - multiplier: The multiplier constant for the constraint.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as greater than or equal to another item’s attribute plus a constant offset.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(greaterThanOrEqualTo constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as less than or equal to another item’s attribute plus a constant offset.
    /// - Parameter constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(lessThanOrEqualToConstant constant: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        return self
    }

    /// Adds a constraint (width) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    // MARK: - Center constraints

    /// Adds a constraint (center X) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func centerXAnchor(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    /// Adds a constraint (center Y) that defines one item’s attribute as equal to another item’s attribute plus a constant offset.
    /// - Parameters:
    ///   - anchor: A layout anchor.
    ///   - constant: The constant offset for the constraint.
    @discardableResult
    func centerYAnchor(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    // MARK: - Helpers

    /// Adds four constraints (top, bottom, leading, trailing) to the current view and another view.
    /// - Parameters:
    ///   - anotherView: The view for the right side of the constraint.
    ///   - insets: The constant inset for the constraint.
    ///   - usingSafeArea: Use safe area or standart anchors.
    func pinAnchors(to anotherView: UIView, insets: UIEdgeInsets = .zero, usingSafeArea: Bool = false) {
        if usingSafeArea {
            topAnchor(equalTo: anotherView.safeTopAnchor, constant: insets.top)
                .leadingAnchor(equalTo: anotherView.safeLeadingAnchor, constant: insets.left)
                .trailingAnchor(equalTo: anotherView.safeTrailingAnchor, constant: -insets.right)
                .bottomAnchor(equalTo: anotherView.safeBottomAnchor, constant: -insets.bottom)
        } else {
            topAnchor(equalTo: anotherView.topAnchor, constant: insets.top)
                .leadingAnchor(equalTo: anotherView.leadingAnchor, constant: insets.left)
                .trailingAnchor(equalTo: anotherView.trailingAnchor, constant: -insets.right)
                .bottomAnchor(equalTo: anotherView.bottomAnchor, constant: -insets.bottom)
        }
    }
    
    func roundCorners(radius: CGFloat = 12.5) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: radius)
        }
    }

    func roundTopCorners(radius: CGFloat = 12.5) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            roundCorners(corners: [.topLeft, .topRight], radius: radius)
        }
    }

    func roundBottomCorners(radius: CGFloat = 12.5) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: radius)
        }
    }

    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
