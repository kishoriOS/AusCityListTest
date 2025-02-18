//
//  DetailView.swift
//  Test_AusCityList_Kishor_iOS
//
//  Created by Shiv on 18/02/25.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var city: City
    
    var body: some View {
        VStack {
            Text(city.city)
                .font(.largeTitle)
                .padding()
            
            Text("Population: \(city.population)")
                .font(.title2)
                .padding()
            
            Text("iso2: \(city.iso2)")
                .padding()
        }
        .navigationTitle(city.city) // Set the navigation bar title to city name
    }
}
