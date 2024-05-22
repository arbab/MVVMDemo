//
//  NLPDemoView.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/15/24.
//

import Foundation
import SwiftUI
import NaturalLanguage

struct NLPDemoView: View {
    @State private var inputString = ""
    
    @State private var results = [String]()
    @State private var sentimentScores = [String]()

    
    let embedding = NLEmbedding.wordEmbedding(for: .english)!
    let tagger = NLTagger(tagSchemes: [.sentimentScore])

    var body: some View {
        NavigationStack {
            VStack {
                List{
                    Section(header: Text("Related words"), footer: Text("uses \"neighbors\" method from NLEmbedding")) {
                        ForEach(results, id: \.self) { item in
                            Text(item)
                        }
                    }
                    Section(header: Text("Sentiment Score words"), footer: Text("uses \"tag\" method from NLTagger")) {
                        ForEach(sentimentScores, id: \.self) { item in
                            Text(item)
                        }
                    }
                }.listStyle(.insetGrouped)
                HStack {
                    TextField("Type a word", text: $inputString)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        results = []
                        let neighbors = embedding.neighbors(for: inputString.lowercased(), maximumCount: 5)
                        for neighbor in neighbors {
                            tagger.string = "\(neighbor.0)"
                            let (sentiment, _) = tagger.tag(at: "\(neighbor.0)".startIndex, unit: .paragraph, scheme: .sentimentScore)
                            var sentimentEmoji = ""
                            if let sentimentScore = Double(sentiment?.rawValue ?? "0") {
                                print(sentimentScore)
                                if sentimentScore > 0.7 {
                                    sentimentEmoji = "😊"
                                } else if sentimentScore < -0.7 {
                                    sentimentEmoji = "😡"
                                } else {
                                    sentimentEmoji = "😐"
                                }
                                
                                sentimentScores.append("\(sentimentScore)")
                            }
                            
                            results.append("Word: \(neighbor.0), Distance: \(neighbor.1.formatted()) \(sentimentEmoji)")

                        }
                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                }
            }
            .navigationTitle("NLP Demo")
        }
        
    }
}

#Preview {
    NLPDemoView()
}
