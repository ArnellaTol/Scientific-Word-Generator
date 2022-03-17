//
//  FormulaAdding.swift
//  App1
//
//  Created by Arnella Tolegen on 03.03.2022.
//

import Foundation
import SwiftUI

struct AddFormula: View{
    @FetchRequest(sortDescriptors: []) var formulas: FetchedResults<Formulas>
    @Environment(\.managedObjectContext) var moc
    
    @State var formulaName = ""
    @State var formula = ""
    @State var parameters = ""
    @State var measure = ""
    
    var body: some View{
        NavigationView{
            Form{
                TextField("Название формулы",text: $formulaName)
                TextField("Формула",text: $formula)
                TextField("Параметры",text: $parameters)
                TextField("Единица измерения",text: $measure)
                
                Button("Сохранить"){
                    do{
                        let formula = Formulas(context: moc)
                        formula.name = formulaName
                        formula.formula = self.formula
                        formula.parameters = parameters
                        formula.measure = measure
                        
                        try moc.save()
                    }catch{
                        print(error)
                    }
                }
                
                let formula = setFormula(formulaName: self.formulaName, formula1: self.formula, parameters: self.parameters, measure: self.measure)
                
            }.navigationTitle("Добавление формул")
        }
    }
}

func setFormula(formulaName: String, formula1: String, parameters: String, measure: String) -> Formulas{
    @FetchRequest(sortDescriptors: []) var formulas: FetchedResults<Formulas>
    @Environment(\.managedObjectContext) var moc
    let formula = Formulas(context: moc)
    formula.formula = formula1
    formula.formula = formulaName
    formula.parameters = parameters
    formula.measure = measure
    return formula
}
