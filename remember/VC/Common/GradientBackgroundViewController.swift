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
        setupBlurEllipse()
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
    
    private func setupBlurEllipse() {
        let ellipseIcon1 = UIImageView(image: UIImage(named: "elipseIcon1"))
        ellipseIcon1.contentMode = .scaleAspectFill
        view.addSubview(ellipseIcon1)
        
        ellipseIcon1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(306)
            make.top.equalToSuperview().offset(612)
            make.width.height.equalTo(62)
        }
        
        // 🔹 "elipse_icon_2" 추가 (위치: x: 0, y: 0, width: 62, height: 62)
        let ellipseIcon2 = UIImageView(image: UIImage(named: "elipseIcon2"))
        ellipseIcon2.contentMode = .scaleAspectFill
        view.addSubview(ellipseIcon2)
        
        ellipseIcon2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.width.height.equalTo(260)
        }
        
        let ellipseIcon3 = UIImageView(image: UIImage(named: "elipseIcon3"))
        ellipseIcon3.contentMode = .scaleAspectFill
        view.addSubview(ellipseIcon3)
        
        ellipseIcon3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(358)
        }
        
        let ellipseIcon4 = UIImageView(image: UIImage(named: "elipseIcon4"))
        ellipseIcon4.contentMode = .scaleAspectFill
        view.addSubview(ellipseIcon4)
        
        ellipseIcon4.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(-100)
            make.bottom.equalToSuperview().offset(100)
            make.width.height.equalTo(358)
        }
    }
}

// ✅ UIColor Hex 변환 확장 메서드 추가
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(hexNumber & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1.0)
            return
        }
        self.init(white: 0.0, alpha: 1.0)
    }
}
