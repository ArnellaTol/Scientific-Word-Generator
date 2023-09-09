//
//  IdeaDirectory.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 23.03.2022.
//

import Foundation
import SwiftUI

struct IdeaList: View {
    var body: some View{
        Form{
            Text("Playing in a group. Set the timer for 5 minutes. Each player explains the word and passes the phone with the app to the next one. The one who has the phone in his hands at the end of time loses.")
            Text("Playing in a group. The player explains the word, remembers the time on the stopwatch. The one who explained his word the fastest won.")
            Text("Playing in pairs. One participant dictates the word, the second writes it down. This way you can check the spelling of words.")
            Text("Playing in two teams. One player from each team draws a word on the board, the other participants guess the word. The team that guessed the word faster than the other gets a point. The team with the highest score wins.")
            Text("Playing alone. Explain the meaning of a word or its translation. Try to do it faster each time. Write down unknown words and find their meaning on the Internet.")
        }.navigationTitle("Ideas & Games")
        
    }
}
