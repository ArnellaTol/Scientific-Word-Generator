//
//  InfoView.swift
//  App1
//
//  Created by Arnella Tolegen on 10.03.2022.
//

import Foundation
import SwiftUI

struct InfoView: View{
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var infos: FetchedResults<Information>
    var information: Information?
    @State var topicName = ""
    @State var infoForDelete = Information()
    var body: some View{
        NavigationView{
            VStack{
                List(infos){ info in HStack{
                    Text("Тема: \(info.topic ?? "Unknown"), Информация: \(info.textInfo ?? "Unknown")")
                    }
                }
                
                TextField("Тема",text: $topicName)
                Button("Удалить"){
                    for var info1 in infos {
                        if(topicName == info1.topic){
                            infoForDelete = info1
                        }
                    }
                    try? moc.delete(infoForDelete)
                }.foregroundColor(.red)
                Spacer().frame(width: 10, height: 50)
                NavigationLink(destination: AddInfo(), label: {Text("Добавить")}) 
                
            }.navigationTitle("Справочник")
        }
    }
}
