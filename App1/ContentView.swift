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
    
    func getFormulas() -> [String]{
        var allNames: [String] = []
        for f in formulas{
            allNames.append(f.name ?? "Unknown")
        }
        return allNames
    }

    func getTopics() -> [String]{
        var allTopics: [String] = []
        for t in infos{
            allTopics.append(t.topic ?? "Unknown")
        }
        return allTopics
    }
    
    func getSymbolsPrefix() ->[String]{
        var allSymbols: [String] = []
        for s in calc{
            allSymbols.append("\(s.symbol ?? "Unknown") (\(s.prefix ?? "Unknown"))")
        }
        return allSymbols
    }
    var body: some View {
        let formulaNames: [String] = getFormulas()
        let infoTopics: [String] = getTopics()
        let calcSymbols: [String] = getSymbolsPrefix()
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
                Text("Калкулятор").font(.title3)
                Form{
                    TextField("Численное значение",text: $fractionNumText)
                    
                    Picker(selection: $numCalc1, label: Text("Обозначение (приставка) исходного значения")){
                        ForEach(calcSymbols, id: \.self) { symbol in
                            Text(symbol)
                        }
                    }
                    
                    Picker(selection: $numCalc2, label: Text("Обозначение (приставка) нужного значения")){
                        ForEach(calcSymbols, id: \.self) { symbol in
                            Text(symbol)
                        }
                    }
                     
                    Button("Вычислить"){
                        fractionNum = NumberFormatter().number(from: fractionNumText)?.doubleValue ?? 0.0
                        for elem in calc{
                            if("\(elem.symbol) (\(elem.prefix))" == calcSymbols[numCalc1]){
                                power1 = elem.fraction
                            }
                        }
                        if(power1>0){
                            for _ in 1...power1{
                                fractionNum *= 10
                            }
                        }
                        else if(power1<0){
                            for _ in power1...(-1){
                                fractionNum *= 0.1
                            }
                        }
                        for elem in calc{
                            if("\(elem.symbol) (\(elem.prefix))" == calcSymbols[numCalc2]){
                                power2 = elem.fraction
                            }
                        }
                        if(power2>0){
                            for _ in 1...power2{
                                fractionNum *= 10
                            }
                        }
                        else if(power2<0){
                            for _ in power2...(-1){
                                fractionNum *= 0.1
                            }
                        }
                        resultFractionNum = fractionNum
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
