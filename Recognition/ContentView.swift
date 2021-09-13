//
//  ContentView.swift
//  Recognition
//
//  Created by Erva Hatun Tekeoğlu on 13.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var image = UIImage()
    @State private var showCameraView: Bool = false
    
    var body: some View {
        VStack {
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
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
            CameraView(selectedImage: .constant(image), showCameraView: .constant(false))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
