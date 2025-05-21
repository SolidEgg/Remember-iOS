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
import RxGesture

class OnboardingViewController: GradientBackgroundViewController {
    var tempUserInfo: TempUserInfo?
    private var selectedStackView: UIStackView?
    private let disposeBag = DisposeBag()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "누구와 작별했나요?"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.text = "친구,반려동물,가족..."
        label.textColor = UIColor.white
        return label
    } ()
    
    private lazy var target1Stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            makeTargetStack(image: UIImage(named: "targetPet"), labelText: "반려동물"),
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
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(named: "LabelColor3"), for: .normal) 
        button.layer.cornerRadius = 16
        return button
    }()
    
    private func makeTargetStack(image: UIImage?, labelText: String) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.isUserInteractionEnabled = true
        stack.layer.borderWidth = 0
        stack.layer.cornerRadius = 12
        stack.layer.borderColor = UIColor.white.cgColor

        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(135)
        }

        // labelText를 tag로 임시 저장 (또는 accessibilityIdentifier를 사용해도 됨)
        stack.accessibilityLabel = labelText

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
    
    private func handleTargetSelection(_ stack: UIStackView) {
        selectedStackView?.layer.borderWidth = 0

        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.white.cgColor
        selectedStackView = stack

        if let label = stack.arrangedSubviews.last as? UILabel {
            tempUserInfo?.farewellTarget = label.text ?? ""
            print("선택된 대상: \(tempUserInfo?.farewellTarget ?? "")")
        }
    }

    private func bindUI() {
        let allStacks = target1Stack.arrangedSubviews + target2Stack.arrangedSubviews
        
        for stack in allStacks {
            guard let targetStack = stack as? UIStackView else { continue }

            targetStack.rx
                .tapGesture()
                .when(.recognized)
                .subscribe(onNext: { [weak self] _ in
                    self?.handleTargetSelection(targetStack)
                })
                .disposed(by: disposeBag)
        }
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                guard let target = self.tempUserInfo?.farewellTarget, !target.isEmpty else {
                    print("작별 대상을 선택해주세요")
                    return
                }
                // 다음 뷰로 이동
                print("선택된 대상: \(target)")
                let tabBarController = TabBarController()

                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = tabBarController
                    sceneDelegate.window?.makeKeyAndVisible()
                }

            })
            .disposed(by: disposeBag)
    }
    
}
