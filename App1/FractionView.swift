//
//  FractionView.swift
//  App1Admin
//
//  Created by Arnella Tolegen on 24.03.2022.
//

import Foundation
import SwiftUI

struct FractionView: View{
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var fractions: FetchedResults<DecimalFractions>
    var fraction: DecimalFractions?
    @State var symbolName = ""
    @State var fractionForDelete = DecimalFractions()
    var body: some View{
        NavigationView{
            VStack{
                List(fractions){ fraction in HStack{
                    Text("Обозначение: \(fraction.symbol ?? "Unknown"), Приставка: \(fraction.prefix ?? "Unknown"), Множитель (степень 10-ти): \(fraction.fraction)")
                    }
                }
                
                TextField("Обозначение",text: $symbolName)
                Button("Удалить"){
                    for f1 in fractions {
                        if(symbolName == f1.symbol){
                            fractionForDelete = f1
                        }
                    }
                    try? moc.delete(fractionForDelete)
                }.foregroundColor(.red)
                Spacer().frame(width: 10, height: 50)
                NavigationLink(destination: AddFraction(), label: {Text("Добавить")})
                
            }.navigationTitle("Единицы измерения")
        }
    }
}
