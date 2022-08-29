//
//  LaunchView.swift
//  SwiftUICrypto
//
//  Created by DONG SHENG on 2021/8/28.
//

import SwiftUI

struct LaunchView: View {
    // 個別成一個 String
    @State private var loadingText: [String] = "正在載入你個人的投資組合...".map{ String($0)}
    @State private var showLoadingText: Bool = false
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State private var counter : Int = 0
    @State private var loops: Int = 0
    
    @Binding var showLaunchView :Bool
    
    var body: some View {
        ZStack{
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack{
                if showLoadingText{
//                    Text(loadingText)


                    HStack(spacing: 2){
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launch.accent)
                                .offset(y: counter == index ? -7 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()){
                
                let lastIndex = loadingText.count - 1
                if counter == lastIndex{
                    counter = 0
                    loops += 1
                    if loops >= 2{
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
