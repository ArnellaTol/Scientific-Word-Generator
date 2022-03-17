//
//  DataBaseController.swift
//  App1
//
//  Created by Arnella Tolegen on 03.03.2022.
//

import Foundation
import CoreData

class DataBaseController: ObservableObject{
    let contailer = NSPersistentContainer(name: "FormulasDB")
    
    init(){
        contailer.loadPersistentStores{ description, error in
            if let error = error{
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
}
