//
//  AdminPanel.swift
//  App1
//
//  Created by Arnella Tolegen on 10.03.2022.
//

import Foundation
import SwiftUI

struct AdminPanel: View {
    
    var body: some View {
        NavigationView{
            Form{
                NavigationLink(destination: FormulaView()){
                    Text("Формулы")}.isDetailLink(false)
                
                NavigationLink(destination: InfoView()){
                    Text("Справочник")}.isDetailLink(false)
            }.navigationTitle("Изменение данных")
            
        }
    }
}
