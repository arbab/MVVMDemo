//
//  NLPDemoView1.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/15/24.
//

import Foundation
import SwiftUI
import NaturalLanguage

struct NLPDemoView1: View {
    @State private var text = "井の中の蛙大海を知らず"
    @State private var tokenized = [String]()
    @State private var dominantLanguageName = ""
    let recognizer = NLLanguageRecognizer()

    
    let embedding = NLEmbedding.wordEmbedding(for: .english)!
    let tagger = NLTagger(tagSchemes: [.sentimentScore])

    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $text)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.gradient, lineWidth: 1))
                Button("Tokenize") {
                    guard !text.isEmpty else { return }
                    dominantLanguageName = ""
                    recognizer.processString(text)
                    if let dominantLanguage = recognizer.dominantLanguage {
                        dominantLanguageName = dominantLanguage.rawValue
                    }
                    let tokenizer = NLTokenizer(unit: .word) //.sentence, .word
                    tokenized = []
                    tokenizer.string = text
                    tokenizer.setLanguage(.japanese)
                    tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { range, attributes in
                        tokenized.append(String(text[range]))
                        return true
                    }
                }.padding()
                Text("\(dominantLanguageName)")
                List(tokenized, id: \.self) { token in
                    Text(token)
                
                }
            }
            .padding()
            .navigationTitle("NLP Tokenizer Demo ")
        }
        
    }
}

#Preview {
    NLPDemoView1()
}
