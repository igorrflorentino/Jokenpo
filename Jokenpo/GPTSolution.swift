//
//  GPTSolution.swift
//  Jokenpo
//
//  Created by Igor Florentino on 28/02/24.
//

import SwiftUI

struct GPTSolution: View {
    @State private var botChoice = "Rock"
    @State private var shouldWin = true
    @State private var score = 0
    @State private var turnCount = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var showEndGameAlert = false

    private let choices = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        VStack {
            Text("Jokenpo Trainer")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Text("Bot Choice: \(botChoice)")
                .font(.title2)
            
            Text("Your Mission: \(shouldWin ? "Win" : "Lose")")
                .font(.title3)
                .padding()
            
            HStack {
                ForEach(choices, id: \.self) { choice in
                    Button(action: {
                        self.makeChoice(choice)
                    }) {
                        Text(choice)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            Text("Score: \(score)")
                .font(.headline)
            
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), dismissButton: .default(Text("OK")) {
                if turnCount >= 10 { // Check if it's time for the end game alert
                    showEndGameAlert = true
                } else {
                    self.nextTurn()
                }
            })
        }
        .alert("Game Over", isPresented: $showEndGameAlert) {
            Button("New Game", action: resetGame)
        } message: {
            Text("Your final score is \(score). Would you like to start a new game?")
        }
    }
    
    func makeChoice(_ playerChoice: String) {
        let correctChoice = correctAnswer(for: botChoice, shouldWin: shouldWin)
        if playerChoice == correctChoice {
            score += 1
            alertTitle = "Correct! +1 point"
        } else {
            score -= 1
            alertTitle = "Wrong! -1 point"
        }
        
        showAlert = true
    }
    
    func nextTurn() {
        botChoice = choices.randomElement()!
        shouldWin.toggle()
        turnCount += 1
    }
    
    func correctAnswer(for botChoice: String, shouldWin: Bool) -> String {
        switch botChoice {
        case "Rock":
            return shouldWin ? "Paper" : "Scissors"
        case "Paper":
            return shouldWin ? "Scissors" : "Rock"
        case "Scissors":
            return shouldWin ? "Rock" : "Paper"
        default:
            return ""
        }
    }
    
    func resetGame() {
        botChoice = choices.randomElement()!
        shouldWin = true
        score = 0
        turnCount = 0
        showEndGameAlert = false
    }
}

struct GPTSolution_Previews: PreviewProvider {
    static var previews: some View {
        GPTSolution()
    }
}

#Preview {
    GPTSolution()
}
