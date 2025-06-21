//
//  CommunityViewController.swift
//  remember
//
//  Created by 김민솔 on 6/21/25.
//

import UIKit
import RxSwift
import RxCocoa
import Combine
import SnapKit

struct Message {
    let text: String
}

class CommunityViewController: GradientBackgroundViewController {
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "기억의 정원"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "소중했던 그 이름을 떠올리며,함께 기억하는 편지를 나눠보세요."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(tableView)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(20)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(120)
        }
        tableView.register(CommunityTableViewCell.self, forCellReuseIdentifier: CommunityTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }

    private func bindUI() {
        let messages = BehaviorRelay<[Message]>(value: [
            Message(text: "또다시 보지 못한다는 게 슬프고, 아직도 눈물이 나. 잘 지내지?"),
            Message(text: "항상 즐거운 일만 가득하길 바래. 정말 보고 싶어!"),
            Message(text: "아직도 너와 함께한 여행을 생각하면 웃음이 나"),
        ])
        messages
            .bind(to: tableView.rx.items(cellIdentifier: CommunityTableViewCell.identifier, cellType: CommunityTableViewCell.self)) { row, message, cell in
                cell.configure(with: message)

                cell.comfortTapped = {
                    print("위로돼요 버튼 클릭 - \(row)번째 셀")
                }

                cell.writeTapped = {
                    print("나도 써볼게요 버튼 클릭 - \(row)번째 셀")
                }
            }
            .disposed(by: disposeBag)
    }

}

