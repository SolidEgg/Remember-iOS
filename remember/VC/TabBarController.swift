//
//  TabBarController.swift
//  remember
//
//  Created by 김민솔 on 3/2/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TabBarController: UITabBarController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    private func setupTabBar() {
        let homeVC = HomeViewController()
        let searchVC = MyLetterViewController()
        let chatVC = CommunityViewController()
        let profileVC = MyPageViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "homeClick")?.withRenderingMode(.alwaysOriginal))
        
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "searchClick")?.withRenderingMode(.alwaysOriginal))
        
        chatVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "chat")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "chatClick")?.withRenderingMode(.alwaysOriginal))
        
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "myPage")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "myPageClick")?.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [homeVC, searchVC, chatVC, profileVC]
        
        // 탭 바 스타일 설정
        tabBar.isTranslucent = true
    }
    
    private func createTabBarItem(imageName: String, tag: Int) -> UITabBarItem {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        
        let selectedImageView = UIImageView(image: image)
        selectedImageView.contentMode = .center
        selectedImageView.backgroundColor = UIColor(hex: "#9C89A3")
        selectedImageView.layer.cornerRadius = 28
        selectedImageView.clipsToBounds = true

        return UITabBarItem(title: "", image: image, selectedImage: image)
    }

    private func updateTabBarAppearance(selectedIndex: Int) {
        guard let items = tabBar.items else { return }
        
        for (index, item) in items.enumerated() {
            if let image = item.image {
                let backgroundColor = (index == selectedIndex) ? UIColor(hex: "#9C89A3") : .white
                item.selectedImage = image.withRenderingMode(.alwaysOriginal)
                
                if let imageView = self.tabBar.subviews[index + 1] as? UIImageView {
                    imageView.backgroundColor = backgroundColor
                }
            }
        }
    }
   
}

