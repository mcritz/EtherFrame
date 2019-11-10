//
//  ImageProcessor.swift
//  CHTTPParser
//
//  Created by Michael Critz on 10/20/19.
//

import SwiftGD

class ImageProcessor {
    var sourceImage: Image
    var output: Image?
    var preferred: Size
    var imageOrientation: Orientation {
        get {
            if sourceImage.size.width == sourceImage.size.height {
                return .square
            }
            return sourceImage.size.width > sourceImage.size.height ? .landscape : .portrait
        }
    }
    func resize() {
        switch imageOrientation {
        case .landscape:
            let landscapeRatio = Double(preferred.width) / Double(sourceImage.size.width)
            let height = Double(sourceImage.size.height) * landscapeRatio
            output = sourceImage.resizedTo(width: preferred.width,
                                           height: Int(height),
                                           applySmoothing: true)
            print("landscape")
            return
        case .portrait, .square:
            let portraitRatio = Double(preferred.height) / Double(sourceImage.size.height)
            let width = Double(sourceImage.size.width) * portraitRatio
            output = sourceImage.resizedTo(width: Int(width),
                                           height: preferred.height,
                                           applySmoothing: true)
            print("portrait, square (\(imageOrientation))")
            return
        }
    }
    func processGreyscale() {
        print("desaturate")
        output?.desaturate()
        output?.reduceColors(max: 16,
                             dither: true)
    }
    func process() {
        resize()
        processGreyscale()
    }
    enum Orientation {
        case portrait, landscape, square
    }
    init(source: Image, preferred: Size) {
        self.sourceImage = source
        self.preferred = preferred
    }
}
