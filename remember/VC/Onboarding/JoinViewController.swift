//
//  JoinViewController.swift
//  remember
//
//  Created by 김민솔 on 5/10/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Realm

class JoinViewController: GradientBackgroundViewController {
    private let disposeBag = DisposeBag()
    private let backButton = UIButton(type: .system)
    private var tempUserInfo: TempUserInfo?
    
    private let logoLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    } ()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    } ()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    } ()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    } ()
    
    private let passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .clear
        textField.textColor = .white
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = UIColor(named: "LabelColor3")
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        bindUI()
    }

    
    private func setupUI() {
        view.addSubview(logoLabel)
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordCheckLabel)
        view.addSubview(passwordCheckTextField)
        view.addSubview(joinButton)
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.equalToSuperview().inset(40)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(36)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(36)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(36)
        }
        
        passwordCheckLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(40)
        }
        
        passwordCheckTextField.snp.makeConstraints{ make in
            make.top.equalTo(passwordCheckLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(40)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(36)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
        backButton.setImage(UIImage(named: "back_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.contentHorizontalAlignment = .left
        backButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(44)
        }

        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func bindUI() {
        joinButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }

                let nickname = self.nicknameTextField.text ?? ""
                let email = self.emailTextField.text ?? ""
                let password = self.passwordTextField.text ?? ""
                
                let tempUserInfo = TempUserInfo(nickname: nickname, email: email, password: password)
                
                let onboardingVC = OnboardingViewController()
                onboardingVC.tempUserInfo = tempUserInfo
                self.navigationController?.pushViewController(onboardingVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

    }
}
