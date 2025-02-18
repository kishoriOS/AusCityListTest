//
//  CityViewModel.swift
//  Test_AusCityList_Kishor_iOS
//
//  Created by Shiv on 18/02/25.
//

import Foundation
import SwiftUI

@MainActor
class CityViewModel: ObservableObject {
    @Published var citiesByState: [String: [City]] = [:]
    @Published var isReversed = false
    private let repository: CityRepositoryProtocol
    
    init(repository: CityRepositoryProtocol = CityRepository()) {
        self.repository = repository
        loadCities()
    }

    func loadCities() {
        if let cachedData = loadFromCache() {
            citiesByState = cachedData
        } else {
            Task {
                do {
                    let cities = try await repository.fetchCities()
                    groupCitiesByState(cities)
                    saveToCache(citiesByState)
                } catch {
                    print("Error loading cities: \(error)")
                }
            }
        }
    }

    func refreshData() async {
        do {
            let cities = try await repository.fetchCities()
            groupCitiesByState(cities)
            saveToCache(citiesByState)
        } catch {
            print("Error refreshing data: \(error)")
        }
    }

//    func reverseList() {
//        isReversed.toggle()
//        citiesByState = citiesByState.mapValues { $0.reversed() }
//    }
    
    func reverseList() {
        Task { @MainActor in
            isReversed.toggle()
            citiesByState = citiesByState.mapValues { $0.reversed() }
        }
    }

    private func groupCitiesByState(_ cities: [City]) {
        citiesByState = Dictionary(grouping: cities) { $0.admin_name }
    }

    private func saveToCache(_ data: [String: [City]]) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "cachedCities")
        }
    }

    private func loadFromCache() -> [String: [City]]? {
        if let savedData = UserDefaults.standard.data(forKey: "cachedCities"),
           let decoded = try? JSONDecoder().decode([String: [City]].self, from: savedData) {
            return decoded
        }
        return nil
    }
}
