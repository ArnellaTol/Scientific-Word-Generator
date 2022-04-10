//
//  InfoForUser.swift
//  App1
//
//  Created by Arnella Tolegen on 10.04.2022.
//

import SwiftUI

struct InfoForUser: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var infos: FetchedResults<Information>
    @State private var num = 0
    var body: some View{
        let infoTopics: [String] = infos.map{$0.topic ?? "Unknown"}
        NavigationView{
            Form{
                Picker(selection: $num, label: Text("Тема")){
                    ForEach(0..<infoTopics.count){ index in
                        Text(infoTopics[index])
                    }
                }
                Text(infos[num].textInfo ?? "")
            }.navigationTitle("Информация")
        }
    }
}
