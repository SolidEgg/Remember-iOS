//
//  OnboardingViewController.swift
//  remember
//
//  Created by 김민솔 on 5/10/25.
//

import UIKit
import RxSwift
import SnapKit
import Realm

class OnboardingViewController: GradientBackgroundViewController {
    var tempUserInfo: TempUserInfo?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "누구와 작별했나요?"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.text = "친구,강아지,가족..."
        label.textColor = UIColor.white
        return label
    } ()
    
    private lazy var target1Stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            makeTargetStack(image: UIImage(named: "targetPet"), labelText: "강아지"),
            makeTargetStack(image: UIImage(named: "targetFreind"), labelText: "친구")
        ])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var target2Stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            makeTargetStack(image: UIImage(named: "targetFamily"), labelText: "가족"),
            makeTargetStack(image: UIImage(named: "targetLover"), labelText: "연인")
        ])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()


    private lazy var targetContainerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [target1Stack, target2Stack])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = UIColor(named: "LabelColor3")
        button.layer.cornerRadius = 16
        return button
    }()
    
    private func makeTargetStack(image: UIImage?, labelText: String) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center

        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(135)
        }
        return stack
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(targetLabel)
        view.addSubview(targetContainerStack)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalToSuperview().inset(40)
        }
        targetLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(40)
        }
        
        targetContainerStack.snp.makeConstraints { make in
            make.top.equalTo(targetLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(view.snp.width).multipliedBy(0.9)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(targetContainerStack.snp.bottom).offset(100)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    private func bindUI() {
        
    }
    
}
