//
//  ContentView.swift
//  ShapesGestures
//
//  Created by Harry Patsis on 31/8/19.
//  Copyright © 2019 Harry Patsis. All rights reserved.
//

import SwiftUI

var totalzindex = 0

struct Card: View {
  var title: String
  @Binding var topZindex: Double
  @State private var zindex : Double = 0
  @State private var selected = false
  @State private var startOffset: CGSize = .zero
  @State private var offset: CGSize = .zero
  private let angle = Double.random(in: -10...10)
  private let xaxis = CGFloat(Float.random(in: -1...1))
  private let yaxis = CGFloat(Float.random(in: -1...1))
  private let zaxis = CGFloat(Float.random(in: -1...1))
  //  @State var offs: CGSize = .zero
  var body: some View {
    let drag = DragGesture()
      .onChanged { value in
        self.offset = CGSize(width: self.startOffset.width + value.translation.width, height: self.startOffset.height + value.translation.height)
        self.selected = true
        self.zindex = self.topZindex + 1
    }
    .onEnded {value in
      self.startOffset = self.offset
      self.selected = false
      self.topZindex += 1
    }
    
    return ZStack {
      Rectangle()
        .fill(selected ? Color.purple : Color.blue)
        .frame(width: 200, height : 110)
        .cornerRadius(10)
        .shadow(radius: selected ? 8 : 4)
//        .blendMode(.normal)
      
      Text(title)
        .foregroundColor(.white)
        .font(.title)
        .bold()
    }
    .rotation3DEffect(.degrees(angle), axis: (x: xaxis, y: yaxis, z: zaxis))
    .zIndex(zindex)
    .offset(offset)
    .animation(.easeInOut)
    .scaleEffect(selected ? 1.1 : 1)
    .gesture(drag)
  }
}

struct ContentView : View {
  //  @GestureState var longPressed = false
  //  @State private var longPressed = false
  //  @State private var offset: CGSize = .zero
  @State var topZindex : Double = 0
  
  var body: some View {
    
    //            if $0.translation.width < -100 {
    //                self.offset = .init(width: -1000, height: 0)
    //            } else if $0.translation.width > 100 {
    //                self.offset = .init(width: 1000, height: 0)
    //            } else {
    //                self.offset = .zero
    //            }
    //    }
    //    let longPress = LongPressGesture()
    //      .onEnded{ _ in
    //        self.longPressed.toggle()
    //    }
    //      .updating($isLongPressed) { value, state, transcation in
    //        state = value
    //    }
    
    
    VStack {
      Card(title: "Card one", topZindex: $topZindex)
      Card(title: "Card two", topZindex: $topZindex)
      Card(title: "Card three", topZindex: $topZindex)
      Card(title: "Card four", topZindex: $topZindex)
      Card(title: "Card five", topZindex: $topZindex)
    //        .offset(offset)
    //        .gesture(drag)
    //      .gesture(longPress)
    }
    
    
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
