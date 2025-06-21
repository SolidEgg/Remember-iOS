//
//  CommunityTableViewCell.swift
//  remember
//
//  Created by 김민솔 on 6/21/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CommunityTableViewCell: UITableViewCell {
    static let identifier = "CommunityTableViewCell"

    let messageLabel = UILabel()
    let comfortButton = UIButton()
    let writeButton = UIButton()
    private let containerView = UIView()

    var comfortTapped: (() -> Void)?
    var writeTapped: (() -> Void)?

    private let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        bindActions()
        setupButtonStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.backgroundColor = UIColor.white.withAlphaComponent(0.1) // 반투명 흰색
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }

        containerView.addSubview(messageLabel)
        containerView.addSubview(comfortButton)
        containerView.addSubview(writeButton)

        messageLabel.numberOfLines = 0
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 16)

        comfortButton.setTitle("🌱  위로돼요", for: .normal)
        comfortButton.setTitleColor(.systemGreen, for: .normal)
        comfortButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        writeButton.setTitle("✉️  나도 써볼게요", for: .normal)
        writeButton.setTitleColor(.systemOrange, for: .normal)
        writeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        // 버튼을 감싸는 스택뷰 추가
        let buttonStackView = UIStackView(arrangedSubviews: [comfortButton, writeButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually

        containerView.addSubview(buttonStackView)

        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(40) // 버튼 높이 고정
        }
    }

    private func bindActions() {
        comfortButton.rx.tap
            .bind { [weak self] in self?.comfortTapped?() }
            .disposed(by: disposeBag)

        writeButton.rx.tap
            .bind { [weak self] in self?.writeTapped?() }
            .disposed(by: disposeBag)
    }

    func configure(with message: Message) {
        messageLabel.text = message.text
    }
    private func setupButtonStyle() {
        comfortButton.setTitle("🌱 위로돼요", for: .normal)
        comfortButton.setTitleColor(.white, for: .normal)
        comfortButton.backgroundColor = UIColor(named: "LabelColor3")?.withAlphaComponent(0.2)
        comfortButton.layer.borderColor = UIColor(named: "LabelColor3")?.cgColor
        comfortButton.layer.borderWidth = 2
        comfortButton.layer.cornerRadius = 15
        comfortButton.layer.masksToBounds = true

        writeButton.setTitle("✉️ 나도 써볼게요", for: .normal)
        writeButton.setTitleColor(.white, for: .normal)
        writeButton.backgroundColor = UIColor(named: "LabelColor3")?.withAlphaComponent(0.2)
        writeButton.layer.borderColor = UIColor(named: "LabelColor3")?.cgColor
        writeButton.layer.borderWidth = 2
        writeButton.layer.cornerRadius = 15
        writeButton.layer.masksToBounds = true
    }
}
