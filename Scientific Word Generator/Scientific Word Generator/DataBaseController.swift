//
//  DataBaseController.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 21.03.2022.
//

import Foundation
import CoreData

class DataBaseController: ObservableObject{
    let contailer = NSPersistentContainer(name: "WordsDataBase")
    init(){
        contailer.loadPersistentStores{ description, error in
            if let error = error{
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}
