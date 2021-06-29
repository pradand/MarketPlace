//
//  MaintenanceViewController.swift
//  AmbevMarketPlace
//
//  Created by Andre & Bianca on 23/08/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit
import Lottie

class MaintenanceViewController: UIViewController {

    private lazy var animationView: AnimationView = {
        let animation = AnimationView(name: Constants.Lottie.Animations.fillingUpBeerCup.filename)
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .autoReverse
        animation.animationSpeed = 1
        animation.frame = self.view.bounds
        return animation
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.play()
    }

    private func setupAnimation() {
        view.addSubview(animationView)
    }
}
