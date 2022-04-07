//
//  ContentView.swift
//  App1
//
//  Created by Arnella Tolegen on 20.01.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var formulas: FetchedResults<Formulas>
    @State var num = 0
    
    @FetchRequest(sortDescriptors: []) var infos: FetchedResults<Information>
    @State var num1 = 0
    
    @FetchRequest(sortDescriptors: []) var calc: FetchedResults<DecimalFractions>
    
    @State var numCalc1 = 0
    @State var numCalc2 = 0
    @State var fractionNumText = ""
    @State var fractionNum: Double = 0.0
    @State var resultFractionNum: Double = 0.0
    @State var resultFractionNumPower = ""
    @State var power1: Int16 = 0
    @State var power2: Int16 = 0
    
    var body: some View {
        let formulaNames: [String] = formulas.map{($0.name ?? "Unknown")+": "+($0.formula ?? "Unknown")}
        let infoTopics: [String] = infos.map{$0.topic ?? "Unknown"}
        let calcSymbols: [String] = calc.sorted{$0.fraction < $1.fraction}.map{($0.symbol ?? "Unknown")+" ("+($0.prefix ?? "Unknown")+")"}
        
        NavigationView{
            VStack{
                Text("Информация").font(.title3)
                Form{
                    Picker(selection: $num1, label: Text("Темы")){
                        ForEach(infoTopics, id: \.self) { tName in
                            Text(tName)
                        }
                    }
                    Text(infos[num1].topic ?? "")
                    Text(infos[num1].textInfo ?? "")
                }
                Spacer()
                Text("Формулы").font(.title3)
                Form{
                    Picker(selection: $num, label: Text("Названия формул")){
                        ForEach(formulaNames, id: \.self) { formulaN in
                            Text(formulaN)
                        }
                    }
                    Text(formulas[num].name ?? "")
                    Text(formulas[num].formula ?? "")
                    Text(formulas[num].information ?? "")
                }
                Spacer()
                Text("Конвентер единиц измерения").font(.title3)
                Form{
                    TextField("Численное значение",text: $fractionNumText)
                    
                    Picker(selection: $numCalc1, label: Text("Обозначение (приставка) исходного значения")){
                        ForEach(calcSymbols, id: \.self) { symbol in
                            Text(symbol)
                        }
                    }
                    Text(calcSymbols[numCalc1])
                    
                    Picker(selection: $numCalc2, label: Text("Обозначение (приставка) нужного значения")){
                        ForEach(calcSymbols, id: \.self) { symbol in
                            Text(symbol)
                        }
                    }
                    Text(calcSymbols[numCalc2])
                    
                    Button("Вычислить"){
                        fractionNum = NumberFormatter().number(from: fractionNumText)?.doubleValue ?? 0.0
                        power1 = calc[numCalc1].fraction
                        print(calc[numCalc1].fraction)
                        print("power1 \(power1)")
                        resultFractionNum = fractionNum * pow(Double(10),Double(power1))
                        power2 = calc[numCalc2].fraction
                        print(calc[numCalc2].fraction)
                        print("power2 \(power2)")
                        resultFractionNum *= pow(Double(10),Double(power1))
                    }
                    Text("Результат: \(resultFractionNum)")
                }
                NavigationLink("View for admin", destination: AdminCheck()).foregroundColor(.white)
                
            }.navigationTitle("Справочник по физике")
        }
    }
}

struct ToggleCustom: View{
    var textToggle: String
    @State var boolToggle: Bool
    var body: some View{
        Toggle(isOn: $boolToggle, label: {
            Text(textToggle).foregroundColor(boolToggle ? Color.blue : Color.gray)
        })
    }
}

struct Menu: View{
    var name: String
    @State var color: Color
    var body: some View{
        ZStack{
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
