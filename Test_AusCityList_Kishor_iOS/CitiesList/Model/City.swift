//
//  City.swift
//  Test_AusCityList_Kishor_iOS
//
//  Created by Shiv on 18/02/25.
//

import Foundation

struct City: Identifiable, Codable {
    let id = UUID()
    let city: String
    let admin_name: String
    let population: String
    let iso2: String
}
