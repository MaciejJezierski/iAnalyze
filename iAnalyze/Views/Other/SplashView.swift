//
//  SplashView.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 13/03/2023.
//

import SwiftUI

struct SplashView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your Splash here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                VStack {
                    Image("FaceGenR")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(0.5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.2
                        self.opacity = 1.00
                    }
                }
            }
            .background(.black)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
