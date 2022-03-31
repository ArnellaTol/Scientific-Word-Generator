//
//  AdminCheck.swift
//  App1
//
//  Created by Arnella Tolegen on 27.03.2022.
//

import Foundation
import SwiftUI

struct AdminCheck: View{
    @State var login: String = ""
    @State var password: String = ""
    var body: some View{
        NavigationView{
            Form{
                TextField("Логин",text: $login)
                TextField("Пароль",text: $password)
                if(login == "Teacher01"){
                    if(password == "123qwerty"){
                        NavigationLink(destination: InfoView()) {
                            Text("Доступ к информации")}
                        NavigationLink(destination: FormulaView()) {
                            Text("Доступ к формулам")}
                        NavigationLink(destination: FractionView()){
                            Text("Доступ к единицам измерения")}.isDetailLink(false)
                    }
                    else{
                        Text("Неверный пароль")
                    }
                }
                else{
                    Text("Неверный логин")
                }
            }.navigationTitle("Проверка аккаунта")
        }
    }
}
