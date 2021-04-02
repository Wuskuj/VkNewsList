//
//  NewsFeedCell.swift
//  VkNewsList
//
//  Created by Филипп on 3/27/21.
//

import UIKit
protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }

    var text: String? { get }

    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomView: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var height: Int { get }
    var widht: Int { get }
}

class NewsFeedCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var postLabel: UILabel!

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!

    @IBOutlet weak var postImageView: WebImageView!

    @IBOutlet weak var bottomView: UIView!

    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    static let reuseId = "NewsFeedCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true

        self.cardView.layer.cornerRadius = 10
        self.cardView.clipsToBounds = true

        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    func set(viewModel: FeedCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.postLabel.text = viewModel.text
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.shareLabel.text = viewModel.shares
        self.viewsLabel.text = viewModel.views
        self.iconImageView.set(imageURL: viewModel.iconUrlString)
        self.postLabel.frame = viewModel.sizes.postLabelFrame
        self.postImageView.frame = viewModel.sizes.attachmentFrame
        self.bottomView.frame = viewModel.sizes.bottomView

//        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
    }
}
