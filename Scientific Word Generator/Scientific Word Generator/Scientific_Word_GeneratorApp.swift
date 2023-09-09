//
//  Scientific_Word_GeneratorApp.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 21.03.2022.
//

import SwiftUI

@main
struct Scientific_Word_GeneratorApp: App {
    @StateObject private var dataBaseController = DataBaseController()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, dataBaseController.contailer.viewContext)
        }
    }
}
