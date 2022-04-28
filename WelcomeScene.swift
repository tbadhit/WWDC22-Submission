//
//  WelcomeScene.swift
//  BeatboxTouch
//
//  Created by Tubagus Adhitya Permana on 19/04/22.
//

import SwiftUI
import AVFoundation

struct WelcomeScene: View {
    
    @State var nagivationToPlayground: Bool = false
    @State var soundEffect: AVAudioPlayer!
    @State var soundEffectButton: AVAudioPlayer!
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background-home").resizable().ignoresSafeArea()
                VStack {
                    Text("Beatbox Touch").font(.system(size: 50)).bold().foregroundColor(.white)
                    Spacer()
                    Image("icon-app").resizable().frame(width: UIScreen.screenWidth / 1.5, height: UIScreen.screenHeight / 2.0).padding(.bottom,70)
                    
                    Text("Let's make music from basic beatbox sound!").font(.largeTitle).fontWeight(.light).foregroundColor(.white).padding(.bottom, 40)
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.nagivationToPlayground = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                                playSoundEffectButton()
                            }
                        }
                    }, label: {
                        Text("Start").font(.system(size: 40)).bold().frame(width: UIScreen.screenWidth / 4).padding(30).background(.yellow).foregroundColor(.black).cornerRadius(10)
                    }).padding(.bottom,60)
                    
                    NavigationLink(destination: BeatboxTouchPlayground(rootIsActive: self.$nagivationToPlayground),
                                   isActive: self.$nagivationToPlayground,label: {
                        EmptyView()
                    })
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func playSoundEffectButton() {
        let sound = Bundle.main.path(forResource: "slide", ofType: "m4a")
        
        do {
            self.soundEffectButton = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.soundEffectButton.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }   
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}
