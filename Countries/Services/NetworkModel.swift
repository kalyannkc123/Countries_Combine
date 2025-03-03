//
//  NetworkModel.swift
//  Countries
//
//  Created by Kalyan Chakravarthy Narne on 2/27/25.
//

import Combine
import Foundation

struct NetworkModel {
    func makeRequest<T: Codable>(at url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
        //Use tryMap when the transformation closure can potentially throw an error.
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
