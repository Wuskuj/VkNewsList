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

    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()

    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()

    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {

        case .presentNewsFeed(feed: let feed, let revealPostIds):
            print(revealPostIds)
            let cells = feed.items.map { (feedItem) in
                self.cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostIds: revealPostIds)
            }

            let feedViewModel = FeedViewModel.init(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }

    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostIds: [Int]) -> FeedViewModel.Cell {
        let object = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)

        let photoAttacments = self.photoAttachments(feedItem: feedItem)

        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = self.dateFormatter.string(from: date)

        let isFullSized = revealPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }

//        let isFullSized = revealPostIds.contains(feedItem.postId)

        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttacments, isFullSizePost: isFullSized)

        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: object?.photo ?? "",
                                       name: object?.name ?? "",
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       sizes: sizes, photoAttachments: photoAttacments)
    }

    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        let profilesOrGroups : [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        return profilesOrGroups.filter({ $0.id == abs(sourceId) }).first
    }

    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                          height: firstPhoto.height,
                                                          widht: firstPhoto.width)
    }

    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG,
                                                                  height: photo.height,
                                                                  widht: photo.width)
        }
    }
}
