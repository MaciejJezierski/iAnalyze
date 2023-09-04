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

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
    }

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: IDScannerView

        init(_ parent: IDScannerView) {
            self.parent = parent
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let image = scan.imageOfPage(at: 0)
            parent.scannedImage = image
            controller.dismiss(animated: true)
        }
    }
}
