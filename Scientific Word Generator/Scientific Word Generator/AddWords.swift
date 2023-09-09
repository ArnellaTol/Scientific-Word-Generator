//
//  AddWords.swift
//  SWG Admin
//
//  Created by Arnella Tolegen on 21.03.2022.
//

import Foundation
import SwiftUI

struct AddWord: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    @State var wordName = ""
    @State var transcription = ""
    
    let wordCategory: [String] = ["physics","chemistry","biology","informatics","your subject"]
    @State var categoryNumber = 0
    
    var body: some View{
        Form{
            TextField("Word:",text: $wordName)
            TextField("Transcription:",text: $transcription)
            Picker(selection: $categoryNumber, label: Text("Subject Category:")){
                ForEach(0..<5){
                    Text(self.wordCategory[$0])
                }
            }
            
            Button("Save"){
                let word = Words(context: moc)
                word.word = wordName
                word.category = wordCategory[categoryNumber]
                word.transcription = transcription
                try? moc.save()
            }
            
        }
        .navigationTitle("Adding words")
    }
}

struct AddWord_Previews: PreviewProvider {
    static var previews: some View {
        AddWord()
            .previewInterfaceOrientation(.portrait)
    }
}
