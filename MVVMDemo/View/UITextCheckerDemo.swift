//
//  UITextCheckerDemo.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/15/24.
//

import Foundation
import SwiftUI

struct SpellCheckerView: View {
    @State private var text = ""
    @State private var guesses: [String]? = []
    
    let textChecker = UITextChecker()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                if let gussess = guesses {
                    List(gussess, id: \.self) { guess in
                        HStack {
                            Text(guess)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            var words = text.components(separatedBy: " ")
                            words.removeLast()
                            words.append(guess)
                            text = words.joined(separator: " ")
                        }
                    }
                }
            }
            .onChange(of: text, { oldValue, newValue in
                let missspelledRange = textChecker.rangeOfMisspelledWord(in: text, range: NSRange(0..<text.utf16.count), startingAt: 0, wrap: false, language: "en_US")
                if missspelledRange.location != NSNotFound {
                    guesses = textChecker.guesses(forWordRange: missspelledRange, in: text, language: "en_US")
                }
            })
            .padding()
            .navigationTitle("UITextChecker Demo")
        }
    }
}

#Preview {
    SpellCheckerView()
}
