//
//  NewsFeedCellLayoutCalculate.swift
//  VkNewsList
//
//  Created by Philip Bratov on 28.03.2021.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomView: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {

    private let screenWidth: CGFloat

    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }

    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizePost: Bool) -> FeedCellSizes {

        var showMoreTextButton = false

        let cardViewWidth = self.screenWidth - Constants.cardInsets.left - Constants.cardInsets.right

        //MARK: - Работа с postLabelFrame

        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: .zero)

        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = (text as NSString).height(width: width, font: Constants.postLabelFont)

            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines

            if !isFullSizePost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }

            postLabelFrame.size = CGSize(width: width, height: height)
        }

        //MARK: - Работаа с moreTextButtonFrame
        var moreTextButtonSize: CGSize = .zero

        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }

        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInserts.left, y: postLabelFrame.maxY)

        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)

        //MARK: - Работа с attachmentFrame

        let attachmentTop = postLabelFrame.size == .zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom

        var postImageFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)

        //        if let photoAttachment = photoAttachment {
        //            let photoHeight: Float = Float(photoAttachment.height)
        //            let photoWidth: Float = Float(photoAttachment.widht)
        //
        //            let ratio = CGFloat(photoHeight / photoWidth)
        //            postImageFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        //        }

        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.widht)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachments.count == 1 {
                postImageFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                postImageFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            }

        }

        //MARK: - Работа с bottomView
        let bottomViewTop = max(postLabelFrame.maxY, postImageFrame.maxY)
        let bottomSize = CGSize(width: cardViewWidth, height: CGFloat(Constants.bottomViewHeight))
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: bottomSize)

        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom

        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: postImageFrame,
                     bottomView: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}
