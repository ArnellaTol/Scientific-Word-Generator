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
    @State var fractionNumSI: Double = 0.0
    @State var resultFractionNumSI = ""
    @State var power1: Int16 = 0
    @State var power2: Int16 = 0
    @State var power3: Int16 = 0
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
                    fractionNumSI = fractionNum

                    power1 = usedCalc[numCalc1].fraction
                    power2 = usedCalc[numCalc2].fraction
                    power3 = 0
                    
                    resultFractionNum = fractionNum * pow(Double(10),Double(power1-power2))
                    
                    while(fractionNumSI>=10){
                        power3+=1
                        fractionNumSI/=10
                    }
                    while(fractionNumSI<=1){
                        power3-=1
                        fractionNumSI*=10
                    }
                    resultFractionNumSI = "\(Float(fractionNumSI)) * 10^\(power1-power2+power3)"
                }
                Text("Результат: \(resultFractionNum)")
                Text("Результат в СИ: \(resultFractionNumSI)")
                
            }.navigationTitle("Конвентер единиц измерения")
        }
    }
}
