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
                guard let feedResponse = feedResponse else { return }
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
            }
        }
    }

}
