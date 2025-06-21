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


