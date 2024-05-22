//
//  ChatBubbleDemoView.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/15/24.
//

import Foundation
import SwiftUI

struct Chat:Identifiable {
    var id: UUID = UUID()
    
    let text: String
    let direction: ChatBubbleShape.Direction
    
    var chatColor: Color {
        switch direction {
        case .left:
            return Color.green
        case .right:
            return Color.blue
        }
    }
}

struct ChatBubble<Content>: View where Content: View {
    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self.direction = direction
    }
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            content()
                .clipShape(ChatBubbleShape(direction: direction))
            if direction == .left {
                Spacer()
            }
        }.padding([(direction == .left) ? .leading : .trailing, .top, .bottom], 20)
        .padding((direction == .right) ? .leading : .trailing, 50)
    }
}


struct ChatBubbleDemoView: View {
    @State var chatText: String = ""
    @State var chats: [Chat] = [
        .init(text: "Hello !", direction: .left),
        .init(text: "Do you have any video courses?", direction: .left),
        .init(text: "Yeah for sure, please checkout DevTechie.com", direction: .right),
        .init(text: "Thanks! Will check it out soon.", direction: .left),
        .init(text: "Can you send your logo for branding?", direction: .left),
        .init(text: "Here you go 👆", direction: .right)
    ]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(chats) { chat in
                            ChatBubble(direction: chat.direction) {
                                Text(chat.text)
                                    .padding(.all, 15)
                                    .foregroundColor(Color.white)
                                    .background(chat.chatColor)
                            }
                        }
                    }
                }
                
                HStack {
                    TextField("Enter message here", text: $chatText)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        chats.append(.init(text: chatText, direction: .right))
                        print(chatText.ranges(of: /[a-z]it/))
                        print(chatText.replacing(/[a-m]at/, with: "dog"))
                        print(chatText.trimmingPrefix(/The/.ignoresCase()))
                        chatText = ""
                    }) {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
            .navigationTitle(" Chat")
        }
    }
}

#Preview(body: {
    ChatBubbleDemoView()
})


struct ChatBubbleShape: Shape {
    enum Direction {
        case left
        case right
    }
    
    let direction: Direction
    
    func path(in rect: CGRect) -> Path {
        return (direction == .left) ? leftBubble(in: rect) : rightBubble(in: rect)
    }
    
    private func leftBubble(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { p in
            p.move(to: CGPoint(x: 25, y: height))
            p.addLine(to: CGPoint(x: width - 20, y: height))
            p.addCurve(to: CGPoint(x: width, y: height - 20),
                       control1: CGPoint(x: width - 8, y: height),
                       control2: CGPoint(x: width, y: height - 8))
            p.addLine(to: CGPoint(x: width, y: 20))
            p.addCurve(to: CGPoint(x: width - 20, y: 0),
                       control1: CGPoint(x: width, y: 8),
                       control2: CGPoint(x: width - 8, y: 0))
            p.addLine(to: CGPoint(x: 21, y: 0))
            p.addCurve(to: CGPoint(x: 4, y: 20),
                       control1: CGPoint(x: 12, y: 0),
                       control2: CGPoint(x: 4, y: 8))
            p.addLine(to: CGPoint(x: 4, y: height - 11))
            p.addCurve(to: CGPoint(x: 0, y: height),
                       control1: CGPoint(x: 4, y: height - 1),
                       control2: CGPoint(x: 0, y: height))
            p.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
            p.addCurve(to: CGPoint(x: 11.0, y: height - 4.0),
                       control1: CGPoint(x: 4.0, y: height + 0.5),
                       control2: CGPoint(x: 8, y: height - 1))
            p.addCurve(to: CGPoint(x: 25, y: height),
                       control1: CGPoint(x: 16, y: height),
                       control2: CGPoint(x: 20, y: height))
            
        }
        return path
    }
    
    private func rightBubble(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let path = Path { p in
            p.move(to: CGPoint(x: 25, y: height))
            p.addLine(to: CGPoint(x:  20, y: height))
            p.addCurve(to: CGPoint(x: 0, y: height - 20),
                       control1: CGPoint(x: 8, y: height),
                       control2: CGPoint(x: 0, y: height - 8))
            p.addLine(to: CGPoint(x: 0, y: 20))
            p.addCurve(to: CGPoint(x: 20, y: 0),
                       control1: CGPoint(x: 0, y: 8),
                       control2: CGPoint(x: 8, y: 0))
            p.addLine(to: CGPoint(x: width - 21, y: 0))
            p.addCurve(to: CGPoint(x: width - 4, y: 20),
                       control1: CGPoint(x: width - 12, y: 0),
                       control2: CGPoint(x: width - 4, y: 8))
            p.addLine(to: CGPoint(x: width - 4, y: height - 11))
            p.addCurve(to: CGPoint(x: width, y: height),
                       control1: CGPoint(x: width - 4, y: height - 1),
                       control2: CGPoint(x: width, y: height))
            p.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            p.addCurve(to: CGPoint(x: width - 11, y: height - 4),
                       control1: CGPoint(x: width - 4, y: height + 0.5),
                       control2: CGPoint(x: width - 8, y: height - 1))
            p.addCurve(to: CGPoint(x: width - 25, y: height),
                       control1: CGPoint(x: width - 16, y: height),
                       control2: CGPoint(x: width - 20, y: height))
            
        }
        return path
    }
}
