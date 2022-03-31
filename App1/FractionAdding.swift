//
//  FractionAdding.swift
//  App1Admin
//
//  Created by Arnella Tolegen on 24.03.2022.
//

import Foundation
import SwiftUI

struct AddFraction: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var fractions: FetchedResults<DecimalFractions>
    
    @State var symbol = ""
    @State var prefix = ""
    @State var fractionText = ""
    var body: some View{
        NavigationView{
            Form{
                TextField("Обозначение",text: $symbol)
                TextField("Приставка",text: $prefix)
                TextField("Множитель (степень 10-ти)",text: $fractionText)
                Button("Сохранить"){
                    do{
                        let frac = DecimalFractions(context: moc)
                        frac.symbol = symbol
                        frac.prefix = prefix
                        frac.fraction = NumberFormatter().number(from: fractionText)?.int16Value ?? 1
                        try moc.save()
                    }catch{
                        print(error)
                    }
                }
            }.navigationTitle("Добавление единиц измерения")
        }
    }
}
