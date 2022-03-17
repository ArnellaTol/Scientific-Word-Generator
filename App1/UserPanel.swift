//
//  UserPanel.swift
//  App1
//
//  Created by Arnella Tolegen on 06.03.2022.
//

import Foundation
import SwiftUI

struct UserPanel: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var formulas: FetchedResults<Formulas>
    @State var num = 0
    
    @FetchRequest(sortDescriptors: []) var infos: FetchedResults<Information>
    @State var num1 = 0
    
    func getFormulas() -> [String]{
        var allNames: [String] = []
        for f in formulas{
            allNames.append(f.name ?? "Unknown")
        }
        return allNames ?? ["Unknown"]
    }

    func getTopics() -> [String]{
        var allTopics: [String] = []
        for t in infos{
            allTopics.append(t.topic ?? "Unknown")
        }
        return allTopics ?? ["Unknown"]
    }
    var body: some View {
        var formulaNames: [String] = getFormulas()
        var infoTopics: [String] = getTopics()
        VStack{
            NavigationView{
                Form{
                    Picker(selection: $num1, label: Text("Темы")){
                        ForEach(infoTopics, id: \.self) { tName in
                            Text(tName)
                        }
                    }
                }.navigationTitle("Справочник по физике")
            }
            NavigationView{
                Form{
                    
                    Picker(selection: $num, label: Text("Формулы")){
                        ForEach(formulaNames, id: \.self) { fName in
                            Text(fName)
                        }
                    }
                    
                }.navigationTitle("Калькулятор с формулами")
            }
        }
    }
}
