//
//  GradientBackgroundViewController.swift
//  remember
//
//  Created by 김민솔 on 4/24/25.
//

import UIKit

class GradientBackgroundViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "0F101C").cgColor,
            UIColor(hex: "2A2F4F").cgColor,
            UIColor(hex: "623E6E").cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
