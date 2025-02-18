//
//  Test_AusCityList_Kishor_iOSApp.swift
//  Test_AusCityList_Kishor_iOS
//
//  Created by Shiv on 18/02/25.
//

import SwiftUI

@main
struct Test_AusCityList_Kishor_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            /*ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)*/
            
            CityListView() 
        }
    }
}
