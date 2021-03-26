//
//  NewsFeedPresenter.swift
//  VkNewsList
//
//  Created by Philip Bratov on 26.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
    switch response {

    case .some:
        print(".some presenter")
    case .presentNewsFeed:
        print(".presentNewsFeed presenter")
        viewController?.displayData(viewModel: .displayNewsFeed)
    }
  }
  
}
