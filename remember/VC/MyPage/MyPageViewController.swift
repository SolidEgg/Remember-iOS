//
//  MyPageViewController.swift
//  remember
//
//  Created by 김민솔 on 4/24/25.
//

import UIKit
import RxSwift
import RxCocoa
import Combine
import SnapKit

class MyPageViewController: GradientBackgroundViewController {
    private let disposeBag = DisposeBag()
    private let nicknameLabel = UILabel()
    private let emailLabel = UILabel()
    private let underlineView = UIView()
    
    private let accountSection = MyPageSectionView(
        title: "TODO LIST",
        items: ["방청소 하기","공원 30초 걷기","카페가서 커피 한 잔"]
    )
    
    private let calendarSection = MyPageLinkSectionView(
        title: "월간 달력",
        buttonTitle: "보러가기"
    )
    
    private let todoSection = MyPageLinkSectionView(
        title: "내가 작성한 편지",
        buttonTitle: "보러가기"
    )
    
    private let otherSection = MyPageSectionView(
        title: "기타",
        items: ["로그아웃", "회원탈퇴","고객센터"]
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // 닉네임
        let nicknameText = NSMutableAttributedString()

        let namePart = NSAttributedString(
            string: "제니",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 25),
                .foregroundColor: UIColor.white
            ]
        )

        let suffixPart = NSAttributedString(
            string: "님",
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.white
            ]
        )
        nicknameText.append(namePart)
        nicknameText.append(suffixPart)

        nicknameLabel.attributedText = nicknameText
        nicknameLabel.textColor = .white
        
        // 이메일
        emailLabel.text = "jenny@naver.com"
        emailLabel.font = .systemFont(ofSize: 13)
        emailLabel.textColor = .lightGray
        
        // 언더라인
        underlineView.backgroundColor = .white
        
        let linkStackView = UIStackView(arrangedSubviews: [calendarSection, todoSection])
        linkStackView.axis = .horizontal
        linkStackView.distribution = .fillEqually
        linkStackView.spacing = 12


        view.addSubview(linkStackView)
        view.addSubview(nicknameLabel)
        view.addSubview(emailLabel)
        view.addSubview(underlineView)
        view.addSubview(accountSection)
        view.addSubview(otherSection)
        view.addSubview(calendarSection)
        view.addSubview(todoSection)
        
        linkStackView.snp.makeConstraints {
            $0.top.equalTo(accountSection.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(80) // 적당한 높이 설정
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.leading.equalToSuperview().offset(24)
        }

        emailLabel.snp.makeConstraints {
            $0.bottom.equalTo(nicknameLabel.snp.bottom)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
        }

        underlineView.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(4)
        }
        
        calendarSection.snp.makeConstraints {
            $0.top.equalTo(accountSection.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(todoSection.snp.leading).offset(-12)
            $0.width.equalTo(todoSection.snp.width)
        }

        todoSection.snp.makeConstraints {
            $0.centerY.equalTo(calendarSection)
            $0.trailing.equalToSuperview().offset(-24)
        }

        accountSection.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        otherSection.snp.makeConstraints {
            $0.top.equalTo(calendarSection.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

class MyPageSectionView: UIView {
    init(title: String, items: [String]) {
        super.init(frame: .zero)
        setupUI(title: title, items: items)
    }

    private func setupUI(title: String, items: [String]) {
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        let titleLabel = UILabel()
        titleLabel.text = "• \(title)"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10

        for item in items {
            let btn = UIButton()
            btn.setTitle(item, for: .normal)
            btn.backgroundColor = UIColor(named: "LabelColor2")
            btn.layer.cornerRadius = 8
            btn.titleLabel?.font = .systemFont(ofSize: 16)
            btn.contentHorizontalAlignment = .left
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0) // 왼쪽 여백
            stack.addArrangedSubview(btn)
        }

        addSubview(titleLabel)
        addSubview(stack)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
        }

        stack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }

    required init?(coder: NSCoder) { fatalError() }
}

class MyPageLinkSectionView: UIView {
    init(title: String, buttonTitle: String) {
        super.init(frame: .zero)
        setupUI(title: title, buttonTitle: buttonTitle)
    }

    private func setupUI(title: String, buttonTitle: String) {
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        let titleLabel = UILabel()
        titleLabel.text = "• \(title)"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20)

        let button = UIButton()
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = .systemFont(ofSize: 16)

        addSubview(titleLabel)
        addSubview(button)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
        }

        button.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(36)
        }
    }

    required init?(coder: NSCoder) { fatalError() }
}
