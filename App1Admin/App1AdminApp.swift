//
//  App1AdminApp.swift
//  App1Admin
//
//  Created by Arnella Tolegen on 20.03.2022.
//

import SwiftUI
import App1

@main
struct App1AdminApp: App {
    @StateObject private var dataBaseController = DataBaseController()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, dataBaseController.contailer.viewContext)
        }
    }
}
