//
//  CongratulationScene.swift
//  BeatboxTouch
//
//  Created by Tubagus Adhitya Permana on 21/04/22.
//

import SwiftUI

struct CongratulationScene: View {
    @Binding var shouldPopToRootView: Bool
    var body: some View {
        ZStack {
            Image("background-congrast").resizable().ignoresSafeArea()
            VStack {
                Text("Congratulations 🎉").foregroundColor(.white).font(.system(size: 70)).bold().padding(.bottom, 45)
                Text("you have successfully made \n music with beatbox sound!").foregroundColor(.white).font(.system(size: 40)).bold()
            }
            
            Button(action: {
                self.shouldPopToRootView = false
            }, label: {
                Text("Play again").font(.system(size: 30)).foregroundColor(.black).bold().padding(30).background(.yellow).cornerRadius(10)
            }).frame(maxHeight: .infinity, alignment: .bottomLeading).padding(.bottom, 200).padding(.trailing, 30)
            
        }
        .navigationBarHidden(true)
    }
}
