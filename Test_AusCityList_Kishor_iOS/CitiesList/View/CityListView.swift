//
//  CityListView.swift
//  Test_AusCityList_Kishor_iOS
//
//  Created by Shiv on 18/02/25.
//

import Foundation
import SwiftUI

struct CityListView: View {
    @StateObject var viewModel = CityViewModel()
    @State private var expandedStates: Set<String> = [] // Track expanded sections
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.citiesByState.keys.sorted(by: viewModel.isReversed ? (>) : (<)), id: \.self) { state in
                    Section {
                        DisclosureGroup(
                            isExpanded: Binding(
                                get: { expandedStates.contains(state) },
                                set: { isExpanding in
                                    if isExpanding {
                                        expandedStates.insert(state)
                                    } else {
                                        expandedStates.remove(state)
                                    }
                                }
                            )
                        ) {
                            ForEach(viewModel.citiesByState[state]!, id: \.id) { city in
                                // Text(city.city)
                                NavigationLink(destination: DetailView(city: city)) {
                                    Text(city.city) // Display city name
                                }
                            }
                        } label: {
                            Text(state).font(.headline)
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.refreshData()
            }
            .navigationTitle("Australian Cities")
            .toolbar {
                Button("Reverse") {
                    viewModel.reverseList()
                }
            }
        }
        .preferredColorScheme(nil) // Dark Mode Support
    }
}
