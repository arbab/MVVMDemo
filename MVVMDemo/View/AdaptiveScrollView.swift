//
//  AdaptiveScrollView.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/16/24.
//

import Foundation
import SwiftUI

struct AdaptiveScrollView<Content>: View where Content: View {
    let content: () -> Content
    //@Binding var scrollOffset: CGFloat = projectedValue
    
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                content().background { Color.green}
                Spacer()
                Color.gray
            }
        }.background{
            GeometryReader { scrollViewGeometry in
                
                Color.blue.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            print("contsize.height: \(scrollViewGeometry.size.height)")
                        }
                    }
                }
            }
        }
    }
}

struct AdaptiveScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveScrollView(content: { VStack { Text("Hello")
            Text("Hello")
            Text("Hello")
            Text("Hello")
            Text("Hello")
            Text("Hello")
            Text("Hello")
        }
        })//, scrollOffset: 0)
    }
}

//struct AdaptiveScrollView_Previews: PreviewProvider {
//    static var preview: some Previews {
//        AdaptiveScrollView(content: { Text("Hello") }, scrollOffset: 0)
//    }
//}
