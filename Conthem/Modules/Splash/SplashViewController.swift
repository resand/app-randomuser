//
//  SplashViewController.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

class SplashViewController: UIViewController {
    var logoSplashLottie: AnimationView!
    var window: UIWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoSplashLottie.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            ContactsWireFrame(in: self.window).rootMovementViewController()
        }
    }

    func setup() {
        logoSplashLottie = AnimationView(name: Constants.Animations.splash)
        logoSplashLottie.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        logoSplashLottie.contentMode = .scaleAspectFit
        logoSplashLottie.backgroundColor = .white
        view.addSubview(logoSplashLottie)
    }
}
