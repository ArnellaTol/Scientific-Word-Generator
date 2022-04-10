//
//  ConventerForUser.swift
//  App1
//
//  Created by Arnella Tolegen on 10.04.2022.
//

import SwiftUI

struct ConventerForUser: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var calc: FetchedResults<DecimalFractions>
    
    @State private var numCalc1 = 0
    @State private var numCalc2 = 0
    @State var fractionNumText = ""
    @State var fractionNum: Double = 0.0
    @State var resultFractionNum: Double = 0.0
    @State var resultFractionNumPower = ""
    @State var power1: Int16 = 0
    @State var power2: Int16 = 0
    var body: some View{
        let usedCalc = calc.sorted{$0.fraction < $1.fraction}
        let calcSymbols: [String] = usedCalc.map{($0.symbol ?? "Unknown")+" ("+($0.prefix ?? "Unknown")+")"}
        
        NavigationView{
            Form{
                TextField("Численное значение",text: $fractionNumText)
                
                Picker(selection: $numCalc1, label: Text("Обозначение (приставка) исходного значения")){
                    ForEach(0..<calcSymbols.count){ index in
                        Text(calcSymbols[index])
                    }
                }
                
                Picker(selection: $numCalc2, label: Text("Обозначение (приставка) нужного значения")){
                    ForEach(0..<calcSymbols.count){ index in
                        Text(calcSymbols[index])
                    }
                }
                
                Button("Вычислить"){
                    fractionNum = NumberFormatter().number(from: fractionNumText)?.doubleValue ?? 0.0
                    
                    power1 = usedCalc[numCalc1].fraction
                    power2 = usedCalc[numCalc2].fraction
                    resultFractionNum = fractionNum * pow(Double(10),Double(power1))
                    if(power2>power1){
                        resultFractionNum *= pow(Double(10),Double(power2*(-1)))
                    }
                    else if(power1>power2){
                        resultFractionNum *= pow(Double(10),Double(power2))
                    }
                }
                Text("Результат в СИ: \(resultFractionNum)")
            }.navigationTitle("Конвентер единиц измерения")
        }
    }
}
