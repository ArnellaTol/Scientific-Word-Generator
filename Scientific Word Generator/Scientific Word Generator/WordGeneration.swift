//
//  WordGeneration.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 21.03.2022.
//

import Foundation
import SwiftUI


func randomIndex(num: Int, subjectsWords: [String])->[Int]{
    var numList: [Int] = []
    if subjectsWords.count > 0{
        for _ in 1...num{
            numList.append(Int.random(in: 0..<subjectsWords.count))
        }
    }
    return numList
}

func newWords(numList: [Int], subjectsWords: [String], num: Int)->[String]{
    var wordList: [String] = []
    if subjectsWords.count > 0{
        for i in 0...(num-1){
            wordList.append(subjectsWords[numList[i]])
        }
    }
    return wordList
}

func newTranscriptions(numList: [Int], subjectsTranscriptions: [String], num: Int)->[String]{
    var transcriptionList: [String] = []
    if subjectsTranscriptions.count > 0{
        for i in 0...(num-1){
            transcriptionList.append(subjectsTranscriptions[numList[i]])
        }
    }
    return transcriptionList
}

struct PhysicsWordGeneration: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    var word: Words?
    
    @State var num: Int = 1
    @State var index = 0
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    func physicsWords()->[String]{
        var physicsWordsMass: [String] = []
        for w in words{
            if(w.category == "physics"){
                physicsWordsMass.append(w.word ?? "no word")
            }
        }
        return physicsWordsMass
    }
    
    func physicsTranscription()->[String]{
        var physicsWordsMass: [String] = []
        for w in words{
            if(w.category == "physics"){
                physicsWordsMass.append(w.transcription ?? "no transcription")
            }
        }
        return physicsWordsMass
    }
    
    @State var randomWordList: [String] = [""]
    @State var randomTranscriptionList: [String] = [""]
    
    var body: some View{
        
        ZStack{
            VStack{
                if(randomWordList.count == 1){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 2){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 3){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[2])").font(.system(size:30))
                    Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 4){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    
                }
                else if(randomWordList.count == 5){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[4])").font(.system(size:30))
                        Text("\(randomTranscriptionList[4])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(Color.cyan).font(.system(size:40)).padding()
                        .onTapGesture {
                            let rand = randomIndex(num: num, subjectsWords: physicsWords())
                            
                            randomWordList = newWords(numList: rand, subjectsWords: physicsWords(), num: num)
                            randomTranscriptionList = newTranscriptions(numList: rand, subjectsTranscriptions: physicsTranscription(), num: num)
                            self.stopwatchManager.stop()
                            self.stopwatchManager.start()
                        }
                    
                    Text(String(format: "%.1f", stopwatchManager.secElapsed)).font(.system(size:30)).padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num<5){
                                num+=1
                            }
                        }
                    
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num>1){
                                num-=1
                            }
                        }
                    Text("\(num)").font(.system(size:30)).padding()
                }
            }.navigationTitle("Physics")
        }
    }
}



struct ChemistryWordGeneration: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    var word: Words?
    
    @State var num: Int = 1
    @State var index = 0
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    func chemistryWords()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "chemistry"){
                WordsMass.append(w.word ?? "no word")
            }
        }
        return WordsMass
    }
    
    func chemistryTranscription()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "chemistry"){
                WordsMass.append(w.transcription ?? "no transcription")
            }
        }
        return WordsMass
    }
    
    @State var randomWordList: [String] = [""]
    @State var randomTranscriptionList: [String] = [""]
    
    var body: some View{
        
        ZStack{
            VStack{
                if(randomWordList.count == 1){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 2){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 3){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[2])").font(.system(size:30))
                    Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 4){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    
                }
                else if(randomWordList.count == 5){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[4])").font(.system(size:30))
                        Text("\(randomTranscriptionList[4])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(Color.cyan).font(.system(size:40)).padding()
                        .onTapGesture {
                            let rand = randomIndex(num: num, subjectsWords: chemistryWords())
                            
                            randomWordList = newWords(numList: rand, subjectsWords: chemistryWords(), num: num)
                            randomTranscriptionList = newTranscriptions(numList: rand, subjectsTranscriptions: chemistryTranscription(), num: num)
                            
                            self.stopwatchManager.stop()
                            self.stopwatchManager.start()
                        }
                    
                    Text(String(format: "%.1f", stopwatchManager.secElapsed)).font(.system(size:30)).padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num<5){
                                num+=1
                            }
                        }
                    
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num>1){
                                num-=1
                            }
                        }
                    Text("\(num)").font(.system(size:30)).padding()
                }
            }.navigationTitle("Chemistry")
        }
    }
}

struct BiologyWordGeneration: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    var word: Words?
    
    @State var num: Int = 1
    @State var index = 0
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    func biologyWords()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "biology"){
                WordsMass.append(w.word ?? "no word")
            }
        }
        return WordsMass
    }
    
    func biologyTranscription()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "biology"){
                WordsMass.append(w.transcription ?? "no transcription")
            }
        }
        return WordsMass
    }
    
    @State var randomWordList: [String] = [""]
    @State var randomTranscriptionList: [String] = [""]
    
    var body: some View{
        
        ZStack{
            VStack{
                if(randomWordList.count == 1){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 2){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 3){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[2])").font(.system(size:30))
                    Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 4){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    
                }
                else if(randomWordList.count == 5){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[4])").font(.system(size:30))
                        Text("\(randomTranscriptionList[4])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(Color.cyan).font(.system(size:40)).padding()
                        .onTapGesture {
                            let rand = randomIndex(num: num, subjectsWords: biologyWords())
                            
                            randomWordList = newWords(numList: rand, subjectsWords: biologyWords(), num: num)
                            randomTranscriptionList = newTranscriptions(numList: rand, subjectsTranscriptions: biologyTranscription(), num: num)
                            
                            self.stopwatchManager.stop()
                            self.stopwatchManager.start()
                        }
                    
                    Text(String(format: "%.1f", stopwatchManager.secElapsed)).font(.system(size:30)).padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num<5){
                                num+=1
                            }
                        }
                    
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num>1){
                                num-=1
                            }
                        }
                    Text("\(num)").font(.system(size:30)).padding()
                }
            }.navigationTitle("Biology")
        }
    }
}

struct ComputerScienceWordGeneration: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    var word: Words?
    
    @State var num: Int = 1
    @State var index = 0
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    func computerScienceWords()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "informatics"){
                WordsMass.append(w.word ?? "no word")
            }
        }
        return WordsMass
    }
    
    func computerScienceTranscription()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "informatics"){
                WordsMass.append(w.transcription ?? "no transcription")
            }
        }
        return WordsMass
    }
    
    @State var randomWordList: [String] = [""]
    @State var randomTranscriptionList: [String] = [""]
    
    var body: some View{
        
        ZStack{
            VStack{
                if(randomWordList.count == 1){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 2){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 3){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[2])").font(.system(size:30))
                    Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 4){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    
                }
                else if(randomWordList.count == 5){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[4])").font(.system(size:30))
                        Text("\(randomTranscriptionList[4])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(Color.cyan).font(.system(size:40)).padding()
                        .onTapGesture {
                            let rand = randomIndex(num: num, subjectsWords: computerScienceWords())
                            
                            randomWordList = newWords(numList: rand, subjectsWords: computerScienceWords(), num: num)
                            randomTranscriptionList = newTranscriptions(numList: rand, subjectsTranscriptions: computerScienceTranscription(), num: num)
                            
                            self.stopwatchManager.stop()
                            self.stopwatchManager.start()
                        }
                    
                    Text(String(format: "%.1f", stopwatchManager.secElapsed)).font(.system(size:30)).padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num<5){
                                num+=1
                            }
                        }
                    
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num>1){
                                num-=1
                            }
                        }
                    Text("\(num)").font(.system(size:30)).padding()
                }
            }.navigationTitle("Informatics")
        }
    }
}

struct YourSubjectWordGeneration: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    var word: Words?
    
    @State var num: Int = 1
    @State var index = 0
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    func yourSubjectWords()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "your subject"){
                WordsMass.append(w.word ?? "no word")
            }
        }
        return WordsMass
    }
    
    func yourSubjectTranscription()->[String]{
        var WordsMass: [String] = []
        for w in words{
            if(w.category == "your subject"){
                WordsMass.append(w.transcription ?? "no transcription")
            }
        }
        return WordsMass
    }
    
    @State var randomWordList: [String] = [""]
    @State var randomTranscriptionList: [String] = [""]
    
    var body: some View{
        
        ZStack{
            VStack{
                if(randomWordList.count == 1){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 2){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 3){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[2])").font(.system(size:30))
                    Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 4){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    
                }
                else if(randomWordList.count == 5){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[4])").font(.system(size:30))
                        Text("\(randomTranscriptionList[4])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(Color.cyan).font(.system(size:40)).padding()
                        .onTapGesture {
                            let rand = randomIndex(num: num, subjectsWords: yourSubjectWords())
                            
                            randomWordList = newWords(numList: rand, subjectsWords: yourSubjectWords(), num: num)
                            randomTranscriptionList = newTranscriptions(numList: rand, subjectsTranscriptions: yourSubjectTranscription(), num: num)
                            
                            self.stopwatchManager.stop()
                            self.stopwatchManager.start()
                        }
                    
                    Text(String(format: "%.1f", stopwatchManager.secElapsed)).font(.system(size:30)).padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num<5){
                                num+=1
                            }
                        }
                    
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num>1){
                                num-=1
                            }
                        }
                    Text("\(num)").font(.system(size:30)).padding()
                }
            }.navigationTitle("Your Subject")
        }
    }
}


struct RandomWordGeneration: View{
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    
    var word: Words?
    
    @State var num: Int = 1
    @State var index = 0
    
    @ObservedObject var stopwatchManager = StopWatchManager()
    
    func randomWords()->[String]{
        var WordsMass: [String] = []
        for w in words{
            WordsMass.append(w.word ?? "no word")
        }
        return WordsMass
    }
    
    func randomTranscription()->[String]{
        var WordsMass: [String] = []
        for w in words{
            WordsMass.append(w.transcription ?? "no transcription")
        }
        return WordsMass
    }
    
    @State var randomWordList: [String] = [""]
    @State var randomTranscriptionList: [String] = [""]
    
    var body: some View{
        
        ZStack{
            VStack{
                if(randomWordList.count == 1){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 2){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 3){
                    Text("\(randomWordList[0])").font(.system(size:30))
                    Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[1])").font(.system(size:30))
                    Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                    Text("\(randomWordList[2])").font(.system(size:30))
                    Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                    Text("")
                }
                else if(randomWordList.count == 4){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    
                }
                else if(randomWordList.count == 5){
                    Group{
                        Text("\(randomWordList[0])").font(.system(size:30))
                        Text("\(randomTranscriptionList[0])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[1])").font(.system(size:30))
                        Text("\(randomTranscriptionList[1])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[2])").font(.system(size:30))
                        Text("\(randomTranscriptionList[2])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[3])").font(.system(size:30))
                        Text("\(randomTranscriptionList[3])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                    Group{
                        Text("\(randomWordList[4])").font(.system(size:30))
                        Text("\(randomTranscriptionList[4])").font(.system(size:20)).foregroundColor(.gray)
                        Text("")
                    }
                }
            }
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .foregroundColor(Color.cyan).font(.system(size:40)).padding()
                        .onTapGesture {
                            let rand = randomIndex(num: num, subjectsWords: randomWords())
                            
                            randomWordList = newWords(numList: rand, subjectsWords: randomWords(), num: num)
                            randomTranscriptionList = newTranscriptions(numList: rand, subjectsTranscriptions: randomTranscription(), num: num)
                            
                            self.stopwatchManager.stop()
                            self.stopwatchManager.start()
                        }
                    
                    Text(String(format: "%.1f", stopwatchManager.secElapsed)).font(.system(size:30)).padding()
                    
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num<5){
                                num+=1
                            }
                        }
                    
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(Color.pink).font(.system(size:40))
                        .onTapGesture {
                            if(num>1){
                                num-=1
                            }
                        }
                    Text("\(num)").font(.system(size:30)).padding()
                }
            }.navigationTitle("Random")
        }
    }
}
