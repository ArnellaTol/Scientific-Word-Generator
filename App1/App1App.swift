//
//  App1App.swift
//  App1
//
//  Created by Arnella Tolegen on 20.01.2022.
//

import SwiftUI

@main
struct App1App: App {
    @StateObject private var dataBaseController = DataBaseController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataBaseController.contailer.viewContext)
                
        }
    }
}
