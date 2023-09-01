//
//  IDScanModule.swift
//  iAnalyze
//
//  Created by Maciej Jezierski on 26/06/2023.
//

import Foundation
import SwiftUI
import VisionKit

struct IDScannerView: UIViewControllerRepresentable {
    @Binding var scannedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // No update needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let parent: IDScannerView
        
        init(_ parent: IDScannerView) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            guard scan.pageCount >= 1 else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            
            let image = scan.imageOfPage(at: 0)
            parent.scannedImage = image
            
            saveImage(image, fileName: "1.png")

            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            // Handle error if needed
            parent.presentationMode.wrappedValue.dismiss()
        }
        private func saveImage(_ image: UIImage, fileName: String) {
                    guard let data = image.pngData(),
                          let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                        return
                    }
                    
                    let fileURL = documentsDirectory.appendingPathComponent(fileName)
                    
                    do {
                        try data.write(to: fileURL)
                        print("Image saved at: \(fileURL.absoluteString)")
                    } catch {
                        print("Failed to save image: \(error)")
                    }
                }
    }
}
