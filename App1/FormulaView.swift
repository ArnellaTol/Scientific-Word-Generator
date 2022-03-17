//
//  FormulaView.swift
//  App1
//
//  Created by Arnella Tolegen on 27.02.2022.
//

import Foundation
import SwiftUI

struct FormulaView: View{
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var formulas: FetchedResults<Formulas>
    var formula: Formulas?
    @State var formulaName = ""
    @State var formulaForDelete = Formulas()
    var body: some View{
        NavigationView{
            VStack{
                List(formulas){ formula in HStack{
                    Text("Название формулы: \(formula.name ?? "Unknown"), Формула: \(formula.formula ?? "Unknown"), Параметры: \(formula.parameters ?? "Unknown"), Единица измерения: \(formula.measure ?? "Unknown")")
                    }
                }
                
                TextField("Формула",text: $formulaName)
                Button("Удалить"){
                    for var formula1 in formulas {
                        if(formulaName == formula1.name){
                            formulaForDelete = formula1
                        }
                    }
                    try? moc.delete(formulaForDelete)
                }.foregroundColor(.red)
                Spacer().frame(width: 10, height: 50)
                NavigationLink(destination: AddFormula(), label: {Text("Добавить")})
                
            }.navigationTitle("Формулы")
        }
    }
}
