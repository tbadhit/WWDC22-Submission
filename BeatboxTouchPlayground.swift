//
//  BeatboxTouchPlayground.swift
//  BeatboxTouch
//
//  Created by Tubagus Adhitya Permana on 19/04/22.
//

import SwiftUI
import AVFoundation

struct BeatboxTouchPlayground: View {
    
    @Binding var rootIsActive: Bool
    
    @State var sound: AVAudioPlayer!
    
    @State var botText: String = botTexts[0]
    
    @State var countDownTimer = 15
    @State var timeRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var isBotTeach: Bool = false
    @State var isBotSaid: Bool = false
    @State var isBotBeatbox: Bool = false
    @State var isTeachB: Bool = false
    @State var isTeachT: Bool = false
    @State var isTeachK: Bool = false
    @State var isTry: Bool = false
    @State var isStart: Bool = false
    @State var isTimerShow: Bool = false
    @State var isBeatboxSoundPlay: Bool = false
    @State var navigateToCongratulationScene: Bool = false
    
    @State var countButton: Int64 = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                
                // MARK: View when bot said
                if isBotSaid {
                    ZStack {
                        BeatboxTouchText()
                        Color.gray.opacity(0.6).ignoresSafeArea()
                    }
                    
                // MARK: View when user try beat
                } else {
                    BeatboxTouchText()
                }
                
                Spacer()
                
                HStack {
                    if isBotBeatbox {
                        Image("botbeatbox")
                    } else {
                        Image("bot")
                    }
                    ZStack(alignment: .bottomTrailing) {
                        Text(botText).font(.system(size: 32)).frame(width: UIScreen.screenWidth / 2, height: 200).padding().background(.gray).cornerRadius(10).padding(.bottom, 40).minimumScaleFactor(0.05)
                        
                        // MARK: View when bot said
                        if isBotSaid {
                            HStack {
                                if botText == botTexts[9] || botText == botTexts[13] {
                                    Button(action: {
                                        self.sound.stop()
                                        if botText == botTexts[9] {
                                            playSound("Pattren beatbox 1")
                                        } else {
                                            playSound("Pattren beatbox 2")
                                        }
                                    }, label: {
                                        Label("", systemImage: "repeat").frame(width: 100, height: 30).font(.system(size: 30)).padding().foregroundColor(.black).background(.yellow).cornerRadius(10)
                                    })
                                }
                                
                                Button(action: {
                                    playSound("pop")
                                    self.countButton += 1
                                    switch countButton {
                                    case 0:
                                        botText = botTexts[0]
                                    case 1:
                                        botText = botTexts[1]
                                    case 2:
                                        botText = botTexts[2]
                                    case 3:
                                        botText = botTexts[3]
                                        withAnimation {
                                            isBotTeach = true
                                            isTeachB.toggle()
                                        }
                                    case 4:
                                        botText = botTexts[4]
                                        withAnimation {
                                            isTeachB.toggle()
                                            isTeachT.toggle()
                                        }
                                    case 5:
                                        botText = botTexts[5]
                                        withAnimation {
                                            isTeachT.toggle()
                                            isTeachK.toggle()
                                        }
                                    case 6:
                                        botText = botTexts[6]
                                        self.sound.stop()
                                        withAnimation {
                                            playSound("success")
                                            isTeachK.toggle()
                                            isBotTeach.toggle()
                                        }
                                    case 7:
                                        botText = botTexts[7]
                                    case 8:
                                        botText = botTexts[8]
                                        withAnimation{
                                            isStart = true
                                            isTimerShow = true
                                        }
                                    case 9:
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                            playSound("Pattren beatbox 1")
                                        }
                                        isStart = false
                                        botText = botTexts[9]
                                        withAnimation{
                                            isBotBeatbox = true
                                            isTimerShow = false
                                            isTry = true
                                        }
                                        
                                    case 10:
                                        self.sound.stop()
                                        playSound("success")
                                        withAnimation{
                                            isBotBeatbox = false
                                            timeRunning = true
                                            isTimerShow = true
                                            isBotSaid = false
                                            isTry = false
                                        }
                                    case 11:
                                        botText = botTexts[11]
                                    case 12:
                                        botText = botTexts[12]
                                        isStart = true
                                    case 13:
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                            playSound("Pattren beatbox 2")
                                        }
                                        botText = botTexts[13]
                                        withAnimation{
                                            isBotBeatbox = true
                                            isStart = false
                                            isTry = true
                                        }
                                    case 14:
                                        self.sound.stop()
                                        playSound("success")
                                        withAnimation{
                                            timeRunning = true
                                            isTimerShow = true
                                            isBotSaid = false
                                            isTry = false
                                            isBotBeatbox = false
                                        }
                                        
                                    default:
                                        print("None")
                                    }
                                }, label: {
                                    Text(isTry ? "Try" : isStart ? "Start" : "Next").frame(width: 100, height: 30).font(.system(size: 30)).padding().foregroundColor(.black).background(.yellow).cornerRadius(10)
                                })
                            }.padding(.bottom, 15)
                            
                            
                        }
                    }
                }
                
                // MARK: Display Timer
                if isTimerShow {
                    // MARK: Display Tutorial Timer
                    if botText == botTexts[8] {
                        HStack {
                            Image("timer").frame(width: UIScreen.screenWidth / 10, height: UIScreen.screenHeight / 20)
                            Text("15").bold().foregroundColor(.yellow).font(.system(size: 50))
                        }.padding(30).overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.red, lineWidth: 4)
                        ).padding(.bottom, 10)
                    } else {
                        // MARK: Display Real Timer
                        HStack {
                            Image("timer").frame(width: UIScreen.screenWidth / 10, height: UIScreen.screenHeight / 20)
                            Text("\(countDownTimer)").bold().foregroundColor(.yellow).font(.system(size: 50)).onReceive(timer){ _ in
                                if countDownTimer > 0 && timeRunning {
                                    countDownTimer -= 1
                                } else if botText == botTexts[9] {
                                    withAnimation{
                                        isTimerShow = false
                                        isBotSaid = true
                                        botText = botTexts[10]
                                        playSound("success")
                                        countDownTimer = 15
                                    }
                                } else if botText == botTexts[13] {
                                    botText = ""
                                    playSound("congrast")
                                    navigateToCongratulationScene = true
                                } else {
                                    timeRunning = false
                                }
                            }
                        }.padding(.bottom, 10)
                    }
                }
                
                // MARK: View when bot teach 1 by 1 beatbox sound
                if isBotTeach {
                    ZStack {
                        BeatboxButtons()
                        Color.gray.opacity(0.6)
                        HStack(spacing: 20) {
                            // MARK: B
                            if isTeachB {
                                Teach(
                                    buttonText: "B",
                                    imageName: "b-expression",
                                    action: {playSound("B")})
                            } else {
                                Spacer()
                            }
                            
                            // MARK: T
                            if isTeachT {
                                Teach(
                                    buttonText: "T",
                                    imageName: "t-expression",
                                    action: {playSound("T")})
                            } else {
                                Spacer()
                            }
                            
                            // MARK: K
                            if isTeachK {
                                Teach(
                                    buttonText: "K",
                                    imageName: "k-expression",
                                    action: {playSound("K snare")})
                            } else {
                                Spacer()
                            }
                        }.padding(.leading, 20)
                    }
                    
                // MARK: View when bot said
                } else if isBotSaid {
                    ZStack {
                        BeatboxButtons()
                        Color.gray.opacity(0.6)
                    }
                    
                // MARK: View when user try beat
                } else {
                    BeatboxButtons(
                        playBeatboxSoundB: {
                            playSound("B")
                        }, playBeatboxSoundT: {
                            playSound("T")
                        }, playBeatboxSoundK: {
                            playSound("K snare")
                        },
                        colorButton: .yellow
                    )
                }
                
                // MARK: Navigate to CongratulationScene
                NavigationLink(destination: CongratulationScene(shouldPopToRootView: self.$rootIsActive),isActive: $navigateToCongratulationScene, label: {
                    EmptyView()
                })
                
            }
        }.navigationBarHidden(true)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                    withAnimation {
                        isBotSaid.toggle()
                    }
                }
            }
    }
    
    // MARK: Func play sound
    func playSound(_ soundName: String) {
        let sound = Bundle.main.path(forResource: soundName, ofType: "m4a")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            
            self.sound.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}



// MARK: View Text Beatbox Touch
struct BeatboxTouchText: View {
    var body: some View {
        Text("Beatbox \(Text("Touch").foregroundColor(.yellow))").font(.system(size: 100)).foregroundColor(.white).padding(.top, 150)
    }
}

// MARK: View 3 button beatbox sound
struct BeatboxButtons: View {
    var playBeatboxSoundB: () -> Void = {}
    var playBeatboxSoundT: () -> Void = {}
    var playBeatboxSoundK: () -> Void = {}
    var colorButton: Color = .gray
    var body: some View {
        HStack(spacing: 20) {
            ButtonSound(text: "B",imageName: "b-expression", action: playBeatboxSoundB, backgroundColor: colorButton)
            ButtonSound(text: "T",imageName: "t-expression", action: playBeatboxSoundT, backgroundColor: colorButton)
            ButtonSound(text: "K",imageName: "k-expression", action: playBeatboxSoundK, backgroundColor: colorButton)
        }.padding(.bottom, 50)
    }
}

// MARK: View teach
struct Teach: View {
    var buttonText: String
    var imageName: String
    var action: () -> Void
    @State var isTapShow: Bool = true
    var body: some View {
        ZStack {
            Rectangle().frame(width: UIScreen.screenWidth / 3.1, height: UIScreen.screenHeight / 2.3).foregroundColor(.black).background(.black).padding(.bottom, 30)
            ButtonSound(text: buttonText, imageName: imageName, action: {
                isTapShow = false
                action()
            }, backgroundColor: .yellow).padding(.bottom, 50)
        }
        .padding(.trailing, 20)
    }
}
