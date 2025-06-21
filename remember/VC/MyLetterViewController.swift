//
//  MyLetterViewController.swift
//  remember
//
//  Created by 김민솔 on 5/1/25.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RealmSwift

struct Letter {
    let date: Date
    let content: String
}

class MyLetterViewController: GradientBackgroundViewController {
    
    private var letters: [MessageObject] = []
    private let disposeBag = DisposeBag()
    
    private let dateLabel = UILabel()
    private let tableView = UITableView()
    private let underlineView = UIView()
    private let lettersRelay = BehaviorRelay<[MessageObject]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#302f4c")
        setupUI()
        setupBindings()
        bindTableView()

    }

    private func setupUI() {
        // 날짜 Label
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dateLabel.textColor = .white
        
        underlineView.backgroundColor = .white

        view.addSubview(dateLabel)
        view.addSubview(underlineView)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.equalToSuperview().offset(20)
        }

        underlineView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(4)
        }
        
        // 테이블뷰
        tableView.register(LetterCell.self, forCellReuseIdentifier: "LetterCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(50)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // Realm에서 불러오기
    private func setupBindings() {
        loadLetters()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        dateLabel.text = formatter.string(from: Date())
    }
    
    func saveLetter(date: Date, content: String) {
        let letter = MessageObject()
        letter.date = date
        letter.content = content

        let realm = try! Realm()
        try! realm.write {
            realm.add(letter)
        }
    }

    private func loadLetters() {
        let realm = try! Realm()
        let results = realm.objects(MessageObject.self).sorted(byKeyPath: "date", ascending: false)
        lettersRelay.accept(Array(results))
    }

    private func bindTableView() {
        tableView.delegate = self
        lettersRelay
            .bind(to: tableView.rx.items(cellIdentifier: "LetterCell", cellType: LetterCell.self)) { row, letter, cell in
                cell.configure(with: letter)
            }
            .disposed(by: disposeBag)
    }

}

class LetterCell: UITableViewCell {
    private let dateButton = UIButton()
    private let messageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(dateButton)
        contentView.addSubview(messageLabel)

        dateButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        dateButton.setTitleColor(.white, for: .normal)
        dateButton.layer.borderColor = UIColor.white.cgColor
        dateButton.layer.borderWidth = 1
        dateButton.layer.cornerRadius = 16

        messageLabel.numberOfLines = 0
        messageLabel.textColor = .white
        messageLabel.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        messageLabel.layer.cornerRadius = 12
        messageLabel.layer.masksToBounds = true
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .left
        messageLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        dateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(60)
            make.height.equalTo(32)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with letter: MessageObject) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        let dateText = formatter.string(from: letter.date)
        dateButton.setTitle(dateText, for: .normal)
        messageLabel.text = letter.content
    }

}

extension MyLetterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LetterCell", for: indexPath) as? LetterCell else {
            return UITableViewCell()
        }
        let letter = letters[indexPath.row]
        cell.configure(with: letter)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
