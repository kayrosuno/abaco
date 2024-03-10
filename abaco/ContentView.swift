//
//  ContentView.swift
//  abaco
//
//  Created by Alejandro Garcia on 25/2/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var num = "0"
    @State var date = Date()
    @State var crownValue: Double = 0.0
    @State var integerValue: Int = 0
    
    
    @State var unidad = 0
    @State var unidadMillar = 0
    @State var decena = 0
    @State var centena = 0
    
    @State private var speechSynthesizer: AVSpeechSynthesizer? // 1) taking outside of the local scope of function `speak()`
      

    
//    var unidades = ["8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9"]
    
    var unidades = [0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0]
    //: [Int] // = Array(repeating: 0, count: 1001) //
    
   
    
    var body: some View {
        VStack {
//            HStack{
//                Text("Número:").font(.largeTitle)
//                Spacer()
//            }
            Text("Numero")
                //.font(.largeTitle)
                .font(.system(size: 64, weight: .heavy))//, design: .rounded))
                .foregroundColor(.purple)
                .padding()
               // .border(Color.purple, width: 3)
                .frame(maxWidth: .infinity)
                .padding()
            Text("\(unidadMillar)   "+"\(centena)   "+"\(decena)   "+"\(unidad)")
                //.font(.largeTitle)
                .font(.system(size: 64, weight: .heavy))//, design: .rounded))
                .foregroundColor(.purple)
                .padding()
               // .border(Color.purple, width: 3)
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 1)
                        )
//                .onAppear{
//                    //unidades.capacity = 1001
//                    for i in 0...1000 {
//                        //  unidades.insert(contentsOf: Collection, at: i)
//                       // unidades.insert(i, at: i)
//                        unidades[i] = i
//                        
//                    }
 //               }

        
            
            HStack{
                Picker("UnidadMillar:", selection: $unidadMillar ) {
                    ForEach(unidades, id: \.self ) { item  in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.inline)
                
                
                Picker("Centena:", selection: $centena ) {
                    ForEach(unidades, id: \.self ) { item  in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.inline)
                
                
                Picker("Decena:", selection: $decena) {
                    ForEach(unidades, id: \.self ) { item  in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.inline)
                
                
                Picker("Unidad:", selection: $unidad) {
                    ForEach(unidades, id: \.self ) { item  in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.inline)
                
                
            }
            Spacer()
            
            
            
            
            
            Button(action: {  //Speech **************************
                
                let audioSession = AVAudioSession() // 2) handle audio session first, before trying to read the text
                       do {
                           try audioSession.setCategory(.playback, mode: .default, options: .duckOthers)
                           try audioSession.setActive(false)
                       } catch let error {
                           print("❓", error.localizedDescription)
                       }
                       
                       speechSynthesizer = AVSpeechSynthesizer()
                       
                        
                
                    var speechUtterance: AVSpeechUtterance
                
                
                if unidadMillar != 0 {
                    speechUtterance = AVSpeechUtterance(string: "\(unidadMillar)"+"\(centena)"+"\(decena)"+"\(unidad)")
                }
                else if centena != 0 {
                    speechUtterance = AVSpeechUtterance(string: "\(centena)"+"\(decena)"+"\(unidad)")
                }
                else if decena != 0 {
                    speechUtterance = AVSpeechUtterance(string: "\(decena)"+"\(unidad)")
                }
                else if unidad != 0 {
                    speechUtterance = AVSpeechUtterance(string: "\(unidad)")
                }
                else {
                    speechUtterance = AVSpeechUtterance(string: "0")
                }
                
                
                    
                
                
                
                speechUtterance.voice = AVSpeechSynthesisVoice(language: "es")
                // Configure the utterance.
//                speechUtterance.rate = 0.57
//                speechUtterance.pitchMultiplier = 0.8
//                speechUtterance.postUtteranceDelay = 0.2
//                speechUtterance.volume = 0.8

                       speechSynthesizer?.speak(speechUtterance)
                
                
                
                
            }  , label: {HStack{
                Text("") .font(.system(size: 64, weight: .heavy))//, design: .rounded))
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 64, weight: .bold))
                   
                    .symbolRenderingMode(.hierarchical)
                    //.symbolEffect(   .bounce.up.byLayer)
                 
            }
            .foregroundColor(Color.purple)
            })
          
            
            Spacer()
            
        }
        .padding()
    }
    
    
    private func round(value: Double, velocity: CDouble) -> Double {
       let roundingRule: FloatingPointRoundingRule
       switch velocity {
           case let x where x < 0: roundingRule = .up
           case let x where x == 0: roundingRule = .toNearestOrAwayFromZero
           case let x where x > 0: roundingRule = .down
           default: roundingRule = .toNearestOrAwayFromZero
       }
       return value.rounded(roundingRule)
    }
}
//
//#Preview {
//    ContentView()
//}
