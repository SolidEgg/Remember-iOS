//
//  Onboarding2ViewController.swift
//  remember
//
//  Created by 김민솔 on 5/17/25.
//

import UIKit
import RxSwift
import SnapKit

class Onboarding2ViewController: GradientBackgroundViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "그 분의 이름을 적어주세요."
        label.textColor = UIColor.white
        return label
    } ()    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(named: "LabelColor3"), for: .normal) 
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(startButton)
        
        titleLabel.snp.makeConstraints { make in
            
        }
        
        nameLabel.snp.makeConstraints { make in
            
        }
        
        startButton.snp.makeConstraints { make in
            
        }
    }
    
    private func bindUI() {
        
    }

}
