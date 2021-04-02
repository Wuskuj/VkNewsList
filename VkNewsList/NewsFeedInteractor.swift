//
//  NewsFeedInteractor.swift
//  VkNewsList
//
//  Created by Philip Bratov on 26.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

    private var revealedPostIds = [Int]()
    private var feedResponse : FeedResponse?

    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    private var fetcher: DataFetcher = NetworkDataFether(networking: NetworkService())
    

    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }

        switch request {
        case .getNewsFeed:
            self.fetcher.getFeed { [weak self] (feedResponse) in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .revealPostIds(postId: let postId):
            revealedPostIds.append(postId)
            presentFeed()
        }
    }

    private func presentFeed() {
        guard let feedResponse = self.feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
    }

}
