////
////  IDScanCameraView.swift
////  iAnalyze
////
////  Created by Maciej Jezierski on 19/03/2023.
////
//
//import Foundation
//import Vision
//import CoreImage
//import CoreML
//
//func scan() {
//
//    guard var inputImage = CIImage(contentsOf: #fileLiteral(resourceName: "IMG.HEIC"))
//    else {fatalError("Image not found")}
//
//    let requestHandler = VNImageRequestHandler(ciImage: inputImage)
//    let documentDetectionRequest = VNDetectDocumentSegmentationRequest()
//    try requestHandler.perform([documentDetectionRequest])
//
//    guard let document = documentDetectionRequest.results?.first,
//          let documentImage = perspectiveCorrectedImage(from : inputImage, VNRectangleObservation: document) else {
//            fatalError("Unable to get document image.")
//    }
//
//
//}
