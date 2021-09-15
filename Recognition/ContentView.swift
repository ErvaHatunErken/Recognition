//
//  ContentView.swift
//  Recognition
//
//  Created by Erva Hatun Tekeoğlu on 13.09.2021.
//

import SwiftUI

struct ContentView: View {
    //@State private var selectedImage = UIImage()
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
     /*
        VStack {
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            Button(action: {
                self.showCameraView = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 24))
                    Text("Take a photo")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showCameraView) {
            CameraView(selectedImage: self.$selectedImage, showCameraView: self.$showCameraView)
        }*/
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
