//
//  GalleryCollectionViewCell.swift
//  VkNewsList
//
//  Created by Philip Bratov on 01.04.2021.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    static let reuseId = "GalleryCollectionViewCell"

    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
        backgroundColor = .red

        myImageView.fillSuperview()
    }

    override func prepareForReuse() {
        myImageView.image = nil
    }

    func set(imageUrl: String?) {
        myImageView.set(imageURL: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
