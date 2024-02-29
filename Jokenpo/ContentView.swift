//
//  ContentView.swift
//  Jokenpo
//
//  Created by Igor Florentino on 28/02/24.
//

import SwiftUI

struct ContentView: View {
    
    static let allJokenpoOptions = ["rock", "paper", "scissors"]
    static let allJokenpoOptionsEmojis = ["rock": "✊","paper": "✋","scissors": "✌️"]
    static let allMissionOptions = [false: "lose", true: "win"]
    @State var jokenpoBotChoise = allJokenpoOptions[Int.random(in: 0...2)]
    @State var shouldWin = Bool.random()
    @State var jokenpoUserChoise = ""
    @State var jokenpoRightAnswer = ""
    @State var score = 0
    @State var matchs = 0
    @State var showScore = false
    @State var showScoreTitle = ""
    @State var showScoreMessage = ""
    @State var showEndGame = false
    let scoreIncrement = 1
    let gameOver = 3
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text("Bot Chose")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                Text(Self.allJokenpoOptionsEmojis[jokenpoBotChoise] ?? "")
                    .font(.system(size: 150))
                Spacer()
                
                if shouldWin{
                    Text("Which one wins?")
                        .foregroundStyle(.green)
                        .font(.title)
                }else{
                    Text("Which one loses?")
                        .foregroundStyle(.red)
                        .font(.title)
                }

                HStack{
                    ForEach(Self.allJokenpoOptions, id:\.self){ jokenpo in
                        Button{
                            jokenpoUserChoise = jokenpo
                            jokenpoPress()
                        }label: {
                            VStack{
                                Text(Self.allJokenpoOptionsEmojis[jokenpo] ?? "")
                            }.font(.system(size: 70))
                        }
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Text("Score: \(score)")
                Text("Matches: \(matchs)")
                Spacer()
            }
            .navigationTitle("Jokenpo Trainer")
            .alert("Game over!", isPresented: $showEndGame) {
                Button("Start Again", action: newGame)
            } message: {
                Text("Your final score was \(score)")
            }
            .alert(showScoreTitle, isPresented: $showScore) {
                Button("Continue", action: newTurn)
            } message: {
                Text(showScoreMessage)
            }
        }
    }
    
    func newTurn(){
        if matchs == gameOver{
            showEndGame = true
        }
        jokenpoBotChoise = Self.allJokenpoOptions[Int.random(in: 0...2)]
        shouldWin.toggle()
        jokenpoUserChoise = ""
    }
    
    func setRightAnswer(){
        switch jokenpoBotChoise{
        case Self.allJokenpoOptions[0]:
            if Self.allMissionOptions[shouldWin] == Self.allMissionOptions[true] {
                jokenpoRightAnswer = Self.allJokenpoOptions[1]
            } else{
                jokenpoRightAnswer = Self.allJokenpoOptions[2]
            }
        case Self.allJokenpoOptions[1]:
            if Self.allMissionOptions[shouldWin] == Self.allMissionOptions[true] {
                jokenpoRightAnswer = Self.allJokenpoOptions[2]
            } else{
                jokenpoRightAnswer = Self.allJokenpoOptions[0]
            }
        case Self.allJokenpoOptions[2]:
            if Self.allMissionOptions[shouldWin] == Self.allMissionOptions[true] {
                jokenpoRightAnswer = Self.allJokenpoOptions[0]
            } else{
                jokenpoRightAnswer = Self.allJokenpoOptions[1]
            }
        default:
            break
        }
    }
    
    func jokenpoPress(){
        setRightAnswer()
        if jokenpoRightAnswer == jokenpoUserChoise {
            score += scoreIncrement
            showScoreTitle = "Correct!"
            showScoreMessage = "+\(scoreIncrement) point"
        } else {
            score -= scoreIncrement
            showScoreTitle = "Wrong! Correct answer is \(jokenpoRightAnswer)"
            showScoreMessage = "-\(scoreIncrement) point"
        }
        matchs += 1
        showScore = true
    }
    
    func newGame(){
        score = 0
        matchs = 0
        newTurn()
    }
}


#Preview {
    ContentView()
}
