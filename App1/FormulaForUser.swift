//
//  FormulaForUser.swift
//  App1
//
//  Created by Arnella Tolegen on 10.04.2022.
//

import SwiftUI

struct FormulaForUser: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var formulas: FetchedResults<Formulas>
    @State private var num = 0
    var body: some View{
        let formulaNames: [String] = formulas.map{($0.name ?? "Unknown")+": "+($0.formula ?? "Unknown")}
        NavigationView{
            Form{
                Picker(selection: $num, label: Text("Формула")){
                    ForEach(0..<formulaNames.count){ index in
                        Text(formulaNames[index])
                    }
                }
                Text(formulas[num].information ?? "")
            }.navigationTitle("Формулы")
        }
    }
}
