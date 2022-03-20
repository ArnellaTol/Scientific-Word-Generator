//
//  ContentView.swift
//  App1Admin
//
//  Created by Arnella Tolegen on 20.03.2022.
//

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
