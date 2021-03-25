//
//  FeedViewController.swift
//  VkNewsList
//
//  Created by Philip Bratov on 25.03.2021.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {

    private let networkService: Networking = NetworkService()
    private var fetcher: DataFetcher = NetworkDataFether(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        fetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { (feedItem) in
                print(feedItem.date)
            }
        }
    }
}
