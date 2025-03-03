//
//  ViewModel.swift
//  Countries
//
//  Created by Kalyan Chakravarthy Narne on 2/27/25.
//

import Foundation
import Combine

struct ViewModel {
    private let countriesInfo: CountriesInfo
    
    init(using countriesInfo: CountriesInfo = NetworkManager()){
        self.countriesInfo = countriesInfo
    }
    
    func getCountries() -> AnyPublisher<[Country], Never> {
        return countriesInfo.getCountries()
            .map { countries in
                countries.filter { $0.name != nil && !$0.name!.isEmpty }
                    .sorted { ($0.name ?? "").lowercased() < ($1.name ?? "").lowercased() }
            }
            .eraseToAnyPublisher()
    }
}


