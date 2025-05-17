//
//  LetterViewController.swift
//  remember
//
//  Created by 김민솔 on 3/2/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RealmSwift

class LetterViewController: GradientBackgroundViewController {

    private let disposeBag = DisposeBag()

    private let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal) // X 버튼
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .clear
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("send", for: .normal) // ✅ 타이틀 설정
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(.labelColor2, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    private let letterTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.autocorrectionType = .no
        textView.returnKeyType = .default
        return textView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "내용을 입력하세요..."
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.layer.cornerRadius = 20
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTodayDate()
        event()
        setupTapGesture()
        observeKeyboard()
    }

    private func setupUI() {
        view.addSubview(dateButton)
        view.addSubview(containerView)
        view.addSubview(sendButton)
        view.addSubview(closeButton)
        containerView.addSubview(letterTextView)
        letterTextView.addSubview(placeholderLabel)

        letterTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        placeholderLabel.snp.makeConstraints { make in
            make.top.equalTo(letterTextView).offset(14)
            make.left.equalTo(letterTextView).offset(16)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(39)
            make.right.equalToSuperview().offset(-39)
            make.bottom.equalTo(sendButton.snp.top).offset(-50)
        }

        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }

    private func setTodayDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let today = formatter.string(from: Date())
        dateButton.setTitle(today, for: .normal)
    }
    
    private func event() {
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        sendButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                let messageText = self.letterTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)

                guard !messageText.isEmpty else {
                    print("메시지가 비어 있습니다.")
                    return
                }

                let message = MessageObject()
                message.content = messageText
                message.date = Date()

                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(message)
                    }
                    print("✅ 메시지 저장 완료: \(message.content)")
                } catch {
                    print("❌ Realm 저장 실패: \(error)")
                }

                // 저장 후 초기화
                self.letterTextView.text = ""
                self.placeholderLabel.isHidden = false
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)

        letterTextView.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                let isEmpty = text.isEmpty
                self.placeholderLabel.isHidden = !isEmpty
                if isEmpty {
                    self.startPlaceholderBlinking()
                } else {
                    self.stopPlaceholderBlinking()
                }
            })
            .disposed(by: disposeBag)

    }
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleContainerTap))
        containerView.addGestureRecognizer(tapGesture)
        
    }

    @objc private func handleContainerTap() {
        view.endEditing(true)
    }
    private func startPlaceholderBlinking() {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.repeat, .autoreverse, .allowUserInteraction],
                       animations: {
            self.placeholderLabel.alpha = 0.2
        }, completion: nil)
    }

    private func stopPlaceholderBlinking() {
        placeholderLabel.layer.removeAllAnimations()
        placeholderLabel.alpha = 1.0
    }
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            sendButton.snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-keyboardHeight - 10)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        sendButton.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

}


