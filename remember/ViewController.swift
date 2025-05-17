//
//  ViewController.swift
//  remember
//
//  Created by 김민솔 on 3/1/25.
//

import UIKit
import RxSwift
import RxCocoa
import Combine
import SnapKit

class ViewController: UIViewController {
    
    private let letterImage = UIImageView()
    private let clickImage = UIImageView()
    private let clickLabel = UILabel()
    private let disposeBag = DisposeBag()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()  // 🌌 배경 그라데이션 추가
        setupBlurEllipse()         // 🔵 블러 타원 추가
        setupUI()                  // 🖼️ 이미지 뷰 추가
        bindUI()                    // 🔄 RxSwift & Combine 동작 추가
    }
    
    private func setupUI() {
        letterImage.image = UIImage(named: "letterIcon")
        letterImage.contentMode = .scaleAspectFit
        clickImage.image = UIImage(named: "polyGon")
        clickImage.contentMode = .scaleAspectFit
        clickLabel.text = "Click"
        clickLabel.font = UIFont.systemFont(ofSize: 16) // 원하는 폰트와 크기로 설정 가능
        clickLabel.textColor = UIColor(red: 236/255, green: 233/255, blue: 233/255, alpha: 1)
        
        view.addSubview(letterImage)
        view.addSubview(clickImage)
        view.addSubview(clickLabel)
        letterImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(149)
        }
        
        clickImage.snp.makeConstraints { make in
            make.centerX.equalTo(letterImage)
            make.top.equalTo(letterImage.snp.bottom).offset(10)
            make.width.height.equalTo(16)
        }
        
        clickLabel.snp.makeConstraints {make in
            make.centerX.equalTo(clickImage)
            make.top.equalTo(clickImage.snp.bottom).offset(5)
        }
        
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "0F101C").cgColor,  // 상단 (0%)
            UIColor(hex: "2A2F4F").cgColor,  // 중간 (50%)
            UIColor(hex: "623E6E").cgColor   // 하단 (100%)
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0) // ✅ 배경을 가장 아래로 삽입
    }
    
    private func setupBlurEllipse() {
        let ellipseView = UIView()
        ellipseView.backgroundColor = UIColor(hex: "FFF9D4").withAlphaComponent(0.3)
        ellipseView.layer.cornerRadius = 150.5  // (301 / 2)
        ellipseView.clipsToBounds = true
        ellipseView.layer.opacity = 1.0 // 완전 불투명 설정 추가

        // ✅ 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 20  // 블러 강도 조절
        blurView.frame = CGRect(x: 0, y: 0, width: 301, height: 301)
        blurView.layer.cornerRadius = 150.5
        blurView.clipsToBounds = true
        
        ellipseView.addSubview(blurView)
        view.addSubview(ellipseView)
  
        ellipseView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(301)
        }
        
        // 🔹 "elipse_icon_1" 추가 (위치: x: 306, y: 612, width: 62, height: 62)
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
    }
    
    private func bindUI() {
        // ✅ RxSwift로 이미지 변경 (3초 후 변경)
//        Observable.just(UIImage(named: "letterIcon"))
//            .delay(.seconds(3), scheduler: MainScheduler.instance)
//            .bind(to: imageView.rx.image)
//            .disposed(by: disposeBag)
        
        // ✅ Combine을 다른 동작으로 변경 (예제: 5초 후 투명도 변경)
//        Just(1.0)
//            .delay(for: .seconds(5), scheduler: RunLoop.main)
//            .sink { [weak self] _ in
//                UIView.animate(withDuration: 1.0) {
//                    self?.imageView.alpha = 0.5  // 투명도 변경
//                }
//            }
//            .store(in: &cancellables)
    }
}



