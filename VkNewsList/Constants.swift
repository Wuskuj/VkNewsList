//
//  Constants.swift
//  VkNewsList
//
//  Created by Philip Bratov on 29.03.2021.
//

import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: CGFloat(8 + Constants.topViewHeight + 8), left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)

    static let bottomViewHeight = 44

    static let buttonViewViewHeight : CGFloat = 44
    static let buttonViewViewWidth : CGFloat = 80

    static let buttonViewViewsIconSize: CGFloat = 24

    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6

    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInserts = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
}
