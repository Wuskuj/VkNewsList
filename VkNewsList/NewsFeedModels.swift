//
//  NewsFeedModels.swift
//  VkNewsList
//
//  Created by Philip Bratov on 26.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
  
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var sizes: FeedCellSizes
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
    }

    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var height: Int
        var widht: Int
    }

    let cells: [Cell]
}
