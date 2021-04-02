//
//  NSString+Height.swift
//  VkNewsList
//
//  Created by Philip Bratov on 28.03.2021.
//

import UIKit

extension NSString {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)

        return ceil(size.height)
    }
}
