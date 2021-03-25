//
//  NetworkService.swift
//  VkNewsList
//
//  Created by Philip Bratov on 25.03.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: Networking {

    private let authService: AuthService

    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }

    /*
            https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.130
            components.scheme //http or https
            components.host //api.vk.com
            components.path //method/users.get
            components.queryItems //parameters - user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.130
     */

    func request(path: String, params: [String : String], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let token = self.authService.token else { return }
        let params = ["filters": "post, photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version

        guard let url = self.url(from: path, params: allParams) else { return }
        let request = URLRequest(url: url)
        let task = self.createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            if let successData = data {
                DispatchQueue.main.async {
                    completion(.success(successData))
                }
            }
        }
    }

    private func url(from path: String, params: [String: String]) -> URL? {
        var components = URLComponents()

        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }

        guard let url = components.url else { return nil}
        print(url)
        return url
    }
}
