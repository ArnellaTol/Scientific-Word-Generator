//
//  AdminAccountCheck.swift
//  App1
//
//  Created by Arnella Tolegen on 06.03.2022.
//

import Foundation
import SwiftUI

struct CheckAdmilAccount: View{
    
    @State var login = ""
    @State var password = ""
    
    var body: some View{
        NavigationView{
            Form{
                TextField("Логин",text: $login)
                TextField("Пароль",text: $password)
                
                
                if(login=="Teacher"){
                    if(password=="Qwerty123"){
                        NavigationLink(destination: AdminPanel()){
                            Text("Вход")}.isDetailLink(false)
                    }
                    else{
                        Text("Неверный пароль")
                    }
                }
                else{
                    Text("Неверный логин")
                }
                
                
            }.navigationTitle("Аккаунт администратора")
        }
    }
}
