//
//  CameraView.swift
//  Recognition
//
//  Created by Erva Hatun Tekeoğlu on 13.09.2021.
//

import UIKit
import SwiftUI
import VisionKit
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var showCameraView: Bool
    @Environment(\.presentationMode) private var presentationMode
    @Binding var recognizedText: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> VNDocumentCameraViewController {
        let cameraVC = VNDocumentCameraViewController()
        cameraVC.delegate = context.coordinator
        return cameraVC
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, $recognizedText)
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<CameraView>) {
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
     
        var parent: CameraView
        var recognizedText: Binding<String>
        init(_ parent: CameraView, _ recognizedText: Binding<String> ) {
            self.parent = parent
            self.recognizedText = recognizedText
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let extractedImages = extractImages(from: scan)
            let processedText = recognizeText(from: extractedImages)
            recognizedText.wrappedValue = processedText
            self.parent.presentationMode.wrappedValue.dismiss()
        }
        
        fileprivate func extractImages( from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else {continue}
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
        
        fileprivate func recognizeText(from images: [CGImage]) -> String {
            var entireRecognizedText = [String]()
            var defaultTexts = ["Orkid","Pantene","Gillette","Alo","Ariel","Daz","Comet","Cheer","Febreze","Oral B","Prima","Ace","Fairy","Joy","Gain","Braun","Blendax","Head&Shoulders"]
            defaultTexts = defaultTexts.map{$0.lowercased()}
            let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
                guard error == nil else {return}
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
                        
                let maximumRecognitionCandidates = 1
                for observation in observations {
                    guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                    entireRecognizedText.append(candidate.string.lowercased())
                }
            }
            recognizeTextRequest.recognitionLevel = .accurate
                    
            for image in images {
                let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
                try? requestHandler.perform([recognizeTextRequest])
            }
             
            let message: String = entireRecognizedText.contains(where: defaultTexts.contains) ? "Congratulations!!! You gained 10 points :)" : "P&G products not found :("
            return message
        }
    }
}
