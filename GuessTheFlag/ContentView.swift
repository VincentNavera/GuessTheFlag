//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vincio on 7/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [ "Estonia","France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var i = 0

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var correct = false
    @State private var wrong = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                Button(action: {
                    self.flagTapped(number)
                    i = number
                }) {
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .flagImage()
                    


                }
                .opacity(number != correctAnswer && correct ? 0 : 1)
                .animation(.default)
                .overlay(Capsule().stroke(number == i && wrong ? Color.red : .black, lineWidth: number == i && wrong ? 3 : 0))

                .overlay(Capsule().stroke(number == correctAnswer && wrong ? Color.green : .black, lineWidth: number == correctAnswer && wrong ? 3 : 0))
                .animation(.spring(response: 0.1, dampingFraction: 0.3))
                .rotation3DEffect(number == correctAnswer && correct ?
                                    .degrees(360) : .degrees(0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )




                .animation(Animation.spring(response: 1, dampingFraction: 0.4)
                            .repeatCount(3, autoreverses: true))
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                Spacer()

            }

        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    wrong = false
                    correct = false

                  })
        })

    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            correct = true

        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            wrong = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

            showingScore = true
        }
    }
    func askQuestion() {
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
