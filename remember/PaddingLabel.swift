//
//  PaddingLabel.swift
//  remember
//
//  Created by 김민솔 on 3/2/25.
//

import UIKit

class PaddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)

    override func drawText(in rect: CGRect) {
        let insets = padding
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}

