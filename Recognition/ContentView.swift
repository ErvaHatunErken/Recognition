//
//  ContentView.swift
//  Recognition
//
//  Created by Erva Hatun Tekeoğlu on 13.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showCameraView: Bool = false
    @State private var recognizedText = "Take a photo to start scanning."
    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                     .fill(Color.gray.opacity(0.2))
                Text(recognizedText)
                     .padding()
                }
                .padding()
            }
        Spacer()
        HStack {
            Spacer()
            Button(action: {
                self.showCameraView = true
            }) {
                Text("Start Scanning")
            }
            .padding()
            .foregroundColor(.white)
            .background(Capsule().fill(Color.blue))
        }
        .padding()
    }
    .navigationBarTitle("Text Recognition")
    .sheet(isPresented: $showCameraView) {
        CameraView(showCameraView: self.$showCameraView, recognizedText: self.$recognizedText)
    } 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
