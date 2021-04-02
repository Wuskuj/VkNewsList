//
//  NewsFeedCodeCel.swift
//  VkNewsList
//
//  Created by Philip Bratov on 29.03.2021.
//

import UIKit

protocol NewsFeedCodeCellDelegate: class {
    func revealPost(for cell: NewsFeedCodeCell)
}
final class NewsFeedCodeCell: UITableViewCell {
    static let reuseIdentifier = "NewsFeedCodeCell"

    weak var delegate: NewsFeedCodeCellDelegate?

    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = .black
        return label
    }()

    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()

    let postImageView: WebImageView = {
        let imageView = WebImageView()
        return imageView
    }()

    let bottomView: UIView = {
        let view = UIView()
        return view
    }()

    //3 layer topView

    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    //3 layer bottomView

    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // 4 layer bottomView

    let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()

    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()

    let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()

    let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()

    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "457k"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()

    let galleryCollectionView = GalleryCollectionView()

    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true

        self.cardView.layer.cornerRadius = 10
        self.cardView.clipsToBounds = true

        self.backgroundColor = .clear
        self.selectionStyle = .none

        moreTextButton.addTarget(self, action: #selector(moreTextButtonAction), for: .touchUpInside)
        //cardView constraints
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerTopView()
        overlayThirdLayerBottomView()
        overlayFourLayerBottomView()
    }

    @objc func moreTextButtonAction() {
        self.delegate?.revealPost(for: self)
    }

    func set(viewModel: FeedCellViewModel) {

        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.date
        self.postLabel.text = viewModel.text
        self.likesLabel.text = viewModel.likes
        self.commentsLabel.text = viewModel.comments
        self.sharesLabel.text = viewModel.shares
        self.viewsLabel.text = viewModel.views
        self.iconImageView.set(imageURL: viewModel.iconUrlString)
        self.postLabel.frame = viewModel.sizes.postLabelFrame
        self.bottomView.frame = viewModel.sizes.bottomView
        self.moreTextButton.frame = viewModel.sizes.moreTextButtonFrame

        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            self.postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }

    private func overlayFirstLayer() {
        contentView.addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }

    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(bottomView)

        //topView constraints
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            topView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.topViewHeight))
        ])
    }

    private func overlayThirdLayerTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.topViewHeight  )),
            iconImageView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.topViewHeight))
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2),
            nameLabel.heightAnchor.constraint(equalToConstant: CGFloat(Constants.topViewHeight / 2 - 2))
        ])

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2),
            dateLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }

    private func overlayThirdLayerBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)

        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.buttonViewViewWidth, height: Constants.buttonViewViewHeight))

        commentsView.anchor(top: bottomView.topAnchor,
                         leading: likesView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.buttonViewViewWidth, height: Constants.buttonViewViewHeight))

        sharesView.anchor(top: bottomView.topAnchor,
                         leading: commentsView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.buttonViewViewWidth, height: Constants.buttonViewViewHeight))

        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.buttonViewViewWidth, height: Constants.buttonViewViewHeight))
    }

    private func overlayFourLayerBottomView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)

        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)

        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)

        viewsView.addSubview(viewsLabel)
        viewsView.addSubview(viewsImage)

        self.helpInFourLayer(view: likesView, imageView: likesImage, label: likesLabel)
        self.helpInFourLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        self.helpInFourLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        self.helpInFourLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)

    }

    private func helpInFourLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: Constants.buttonViewViewsIconSize),
            imageView.widthAnchor.constraint(equalToConstant: Constants.buttonViewViewsIconSize)
        ])

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
