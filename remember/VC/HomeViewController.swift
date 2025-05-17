//
//  HomeViewController.swift
//  remember
//
//  Created by 김민솔 on 3/2/25.
//

import UIKit
import RxSwift
import RxCocoa
import Combine
import SnapKit

class HomeViewController: GradientBackgroundViewController {
    
    private let letterImage = UIImageView()
    private let clickImage = UIImageView()
    private let blurImage = UIImageView()
    private let clickLabel = UILabel()
    private let introduceLabel = UILabel()
    private let disposeBag = DisposeBag()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlurEllipse()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        letterImage.image = UIImage(named: "letterIcon")
        letterImage.contentMode = .scaleAspectFit
        letterImage.isUserInteractionEnabled = true
        clickImage.image = UIImage(named: "polyGon")
        clickImage.contentMode = .scaleAspectFit
        blurImage.image = UIImage(named: "elipseLetter")
        blurImage.contentMode = .scaleAspectFill
        clickLabel.text = "Click"
        clickLabel.font = UIFont.systemFont(ofSize: 16)
        let introduceLabel = PaddingLabel()
        introduceLabel.text = "어서와 제니 편지쓰러 가볼래?"
        introduceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        introduceLabel.textAlignment = .center
        introduceLabel.backgroundColor = .clear
       // introduceLabel.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 패딩 추가
        introduceLabel.layer.cornerRadius = 20
        introduceLabel.clipsToBounds = true
        introduceLabel.layer.borderColor = UIColor.white.cgColor
        introduceLabel.layer.borderWidth = 1
        clickLabel.textColor = UIColor(red: 236/255, green: 233/255, blue: 233/255, alpha: 1)
        introduceLabel.textColor = UIColor(red: 236/255, green: 233/255, blue: 233/255, alpha: 1)
        view.addSubview(blurImage)
        view.addSubview(letterImage)
        view.addSubview(clickImage)
        view.addSubview(clickLabel)
        view.addSubview(introduceLabel)
        blurImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(360)
        }
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
        
        introduceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(letterImage)
            make.top.equalToSuperview().offset(200)
        }
        
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
    
    private func bindUI() {
        // ✅ 탭 제스처를 Rx로 처리
        let tapGesture = UITapGestureRecognizer()
        letterImage.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                let vc = LetterViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
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

