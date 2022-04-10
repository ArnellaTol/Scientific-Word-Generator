//
//  ContentView.swift
//  App1
//
//  Created by Arnella Tolegen on 20.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State var select: Int? = 0

    var body: some View {
       NavigationView{
            VStack{
                Text("Справочник по физике").font(.system(size:60)).padding(EdgeInsets(top: -250, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(destination: InfoForUser(), tag: 1, selection: $select) {
                    EmptyView()
                }
                NavigationLink(destination: FormulaForUser(), tag: 2, selection: $select) {
                    EmptyView()
                }
                NavigationLink(destination: ConventerForUser(), tag: 3, selection: $select) {
                    EmptyView()
                }
                Button(action: {
                    self.select = 1
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 50).frame(width: 300, height: 75).foregroundColor(Color.cyan)
                        Text("Информация").foregroundColor(Color.white).font(.title).bold()
                    }
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                Button(action: {
                    self.select = 2
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 50).frame(width: 300, height: 75).foregroundColor(Color.cyan)
                        Text("Формулы").foregroundColor(Color.white).font(.title).bold()
                    }
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                Button(action: {
                    self.select = 3
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 50).frame(width: 300, height: 75).foregroundColor(Color.cyan)
                        Text("Конвентер").foregroundColor(Color.white).font(.title).bold()
                    }
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                NavigationLink("View for admin", destination: AdminCheck()).foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
