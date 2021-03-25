//
//  NetworkDataFetcher.swift
//  VkNewsList
//
//  Created by Philip Bratov on 25.03.2021.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFether: DataFetcher {
    let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, params: params) { (result) in
            switch result {

            case .success(let data):
                let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
                response(decoded?.response)
            case .failure(let error):
                response(nil)
                print(error)
            }
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }

}
