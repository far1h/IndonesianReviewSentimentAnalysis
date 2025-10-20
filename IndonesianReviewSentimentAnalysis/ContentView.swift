//
//  ContentView.swift
//  IndonesianReviewSentimentAnalysis
//
//  Created by Farih Muhammad on 20/10/2025.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var textInput: String = ""
    @State private var sentimentResult: String = ""
    
    let model = try! IndonesianReviewSentimentAnalysis(configuration: MLModelConfiguration())
    
    private func analyzeSentiment() {
     
        do {
            sentimentResult = try model.prediction(text: textInput).label
        } catch {
            sentimentResult = "Error analyzing sentiment"
        }
        
    }
    
    private func getSentimentBackgroundColor(sentiment: String) -> Color {
        switch sentiment {
        case "Positive":
            return Color.green.opacity(0.3)
        case "Negative":
            return Color.red.opacity(0.3)
        default:
            return Color.clear
        }
    }
    
    var body: some View {
        VStack {
            Text("Indonesian Review Sentiment Analysis")
                .font(.title)
                .padding()
            
            TextEditor(text: $textInput)
                .border(Color.gray, width: 1)
                .padding()
                .frame(height: 200)
            
            Button(action: analyzeSentiment) {
                Text("Analyze Sentiment")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if !sentimentResult.isEmpty {
                Text("Sentiment: \(sentimentResult)")
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .background(getSentimentBackgroundColor(sentiment: sentimentResult))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
