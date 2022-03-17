//
//  ContentView.swift
//  App1
//
//  Created by Arnella Tolegen on 20.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("background").resizable()
                VStack{
                    NavigationLink(destination: UserPanel()){
                        Text("Пользователь (ученик)")}
                    
                    NavigationLink(destination: CheckAdmilAccount()){
                        Text("Администратор (учитель)")}
                    
                }.navigationTitle("Аккаунт")
            }
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
