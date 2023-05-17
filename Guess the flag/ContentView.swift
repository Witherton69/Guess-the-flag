//
//  ContentView.swift
//  GuessThatFlag
//
//  Created by Witherton on 4/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ]
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State var currentScore = 0
    @State var scoreTitle = ""
    @State var showingAlert = false
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(num: Int){
        if num == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong"
            
            if currentScore > 0 {
                currentScore -= 1
            }
        }
        
        
        showingAlert = true
    }

    var body: some View {
        ZStack {
            
            Color.blue.ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    
                
                    ForEach(0..<3) { number in
                        
                        Button {
                            flagTapped(num: number)
                        } label: {
                            
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }

                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()

                // Displays the current score to the user
                Text("Score: " + String(currentScore))
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is " + String(currentScore))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
