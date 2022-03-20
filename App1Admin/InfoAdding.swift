//
//  InfoAdding.swift
//  App1Admin
//
//  Created by Arnella Tolegen on 20.03.2022.
//

import Foundation
import SwiftUI

struct AddInfo: View{
    @FetchRequest(sortDescriptors: []) var infos: FetchedResults<Information>
    @Environment(\.managedObjectContext) var moc
    
    @State var topic = ""
    @State var textInfo = ""
    
    var body: some View{
        NavigationView{
            Form{
                TextField("Тема",text: $topic)
                TextField("Информация",text: $textInfo)
                
                Button("Сохранить"){
                    do{
                        let info = Information(context: moc)
                        info.topic = topic
                        info.textInfo = textInfo
                        
                        try moc.save()
                    }catch{
                        print(error)
                    }
                }
                
                let info = setInfo(topic: self.topic, textInfo: self.textInfo)
                
            }.navigationTitle("Добавление информации")
        }
    }
}

func setInfo(topic: String, textInfo: String) -> Information{
    @FetchRequest(sortDescriptors: []) var infos: FetchedResults<Information>
    @Environment(\.managedObjectContext) var moc
    let info = Information(context: moc)
    info.topic = topic
    info.textInfo = textInfo
    return info
}
