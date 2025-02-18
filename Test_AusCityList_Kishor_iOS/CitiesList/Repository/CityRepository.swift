//
//  CityRepository.swift
//  Test_AusCityList_Kishor_iOS
//
//  Created by Shiv on 18/02/25.
//

import Foundation

protocol CityRepositoryProtocol {
    func fetchCities() async throws -> [City]
}

class CityRepository: CityRepositoryProtocol {
    func fetchCities() async throws -> [City] {
        // Simulate API call (Replace with real API later)
        let url = Bundle.main.url(forResource: "cities", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([City].self, from: data)
    }
}
