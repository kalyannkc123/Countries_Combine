//
//  NetworkManager.swift
//  Countries
//
//  Created by Kalyan Chakravarthy Narne on 2/27/25.
//

import Combine
import Foundation

protocol CountriesInfo {
    func getCountries() -> AnyPublisher<[Country], Never>
}

enum NetworkError: Error {
    case invalidResponse
}

struct NetworkManager: CountriesInfo {
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel = NetworkModel()) {
        self.networkModel = networkModel
    }
    
    func getCountries() -> AnyPublisher<[Country], Never> {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
            fatalError("Invalid URL")
        }
        return networkModel.makeRequest(at: url)
            .catch { error -> Just<[Country]> in
                print("Error: \(error)")
                return Just([]) // Provide an empty array in case of error
            }
            .eraseToAnyPublisher()
    }
}


//return networkModel.makeRequest(at: url)
//       .map { (result: [Country]) -> [Country] in
//           // Process the result here if needed
//           // For example, you might want to sort the countries alphabetically
//           return result.sorted { $0.name ?? " " < $1.name ?? "" }
//       }
//       .replaceError(with: [])
//       .eraseToAnyPublisher()
