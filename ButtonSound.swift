//
//  ButtonSound.swift
//  BeatboxTouch
//
//  Created by Tubagus Adhitya Permana on 21/04/22.
//

import SwiftUI

struct ButtonSound: View {
    var text: String
    var imageName: String
    var action: () -> Void
    @State var backgroundColor: Color = .gray
    var body: some View {
        Button(action: action, label: {
            VStack {
                Image(imageName).frame(width: UIScreen.screenWidth / 5 , height: UIScreen.screenHeight / 5)
                Text(text).bold().font(.system(size: 100))
                Spacer()
            }.frame(width: UIScreen.screenWidth / 3.5, height: UIScreen.screenHeight / 2.5).foregroundColor(.black).background(backgroundColor).cornerRadius(10)
        }).onLongPressGesture() {
        } onPressingChanged: { inProgres in
            backgroundColor = inProgres ? .gray : .yellow
        }
        .gesture(DragGesture()
            .onEnded {_ in
                backgroundColor = .gray
            })
    }
}
