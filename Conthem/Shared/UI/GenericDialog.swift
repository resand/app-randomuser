//
//  GenericDialog.swift
//  Conthem
//
//  Created by René Sandoval on 08/08/22.
//

import UIKit

protocol GenericDialogDelegate {
    func didHide()
}

internal class GenericDialog: UIView {
    public var delegate: GenericDialogDelegate?

    lazy var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        dimmedView.addGestureRecognizer(tapGesture)

        addSubview(dimmedView)
        dimmedView.topAnchor(equalTo: topAnchor)
        dimmedView.bottomAnchor(equalTo: bottomAnchor)
        dimmedView.leadingAnchor(equalTo: leadingAnchor)
        dimmedView.trailingAnchor(equalTo: trailingAnchor)

        addSubview(containerView)
        containerView.centerXAnchor(equalTo: centerXAnchor)
        containerView.centerYAnchor(equalTo: centerYAnchor)
        containerView.widthAnchor(equalTo: widthAnchor, multiplier: 0.85)
        containerView.heightAnchor(equalTo: heightAnchor, multiplier: 0.45)

        setupView()
    }

    func show() {
        fadeIn()
    }

    @objc func hide() {
        fadeOut()
    }

    private func fadeIn() {
        isHidden = false
        containerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        containerView.alpha = 0

        UIView.animate(withDuration: 0.2) {
            self.containerView.transform = CGAffineTransform.identity
            self.containerView.alpha = 1
        }
    }

    @objc private func fadeOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.containerView.alpha = 0
        }, completion: { _ in
            self.isHidden = true
            self.delegate?.didHide()
        })
    }

    open func setupView() {}
}
