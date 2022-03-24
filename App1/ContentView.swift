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
    var body: some View {
        let formulaNames: [String] = getFormulas()
        let infoTopics: [String] = getTopics()
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
                    Text("Приставка")
                }
                
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
