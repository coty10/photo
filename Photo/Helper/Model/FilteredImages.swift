//
//  filteredImages.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 13/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit

class filteredImages {
    static var filterToApply: Filter!
    static var filterNames = [
        "Originale","Seppia","Poster", "Vignetta", "Caldo", "Negativo",
        "Fredda", "Vintage", "Pellicola", "Rullino Bianco e Nero",
        "Noir", "Patina", "Acquarello",
        "Acceso", "Neon", "Glow"
    ]
    
    static var filteredImages = [UIImage]()
    static var filteredImage: UIImage!
    
    static func createImageArray(inputImage: CIImage, onSuccess: @escaping () -> () ) {
        filteredImages.removeAll()
        for filter in filterNames {
            switch filter {
            case "Originale":
                filteredImage = UIImage(ciImage:inputImage)
            case "Seppia":
                filterToApply = SepiaTone(inputImage: inputImage, inputIntensity: 0.8)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Poster":
                filterToApply = ColorPosterize(inputImage: inputImage, inputLevels: 16)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Vignetta":
                filterToApply = Vignette(inputImage: inputImage, inputIntensity: 2.0, inputRadius: 10.0)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Caldo":
                filterToApply = TemperatureAndTint(inputImage: inputImage, inputNeutral: CIVector(x:500.0, y:0.0), inputTargetNeutral: CIVector(x:3500.0, y:0.0))
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Negativo":
                filterToApply = ColorInvert(inputImage: inputImage)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Fredda":
                filterToApply = ColorMonochrome(inputImage: inputImage, inputColor: CIColor.blue, inputIntensity: 0.5)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Vintage":
                filterToApply = PhotoEffectChrome(inputImage: inputImage)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Pellicola":
                filterToApply = PhotoEffectFade(inputImage: inputImage)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Rullino Bianco e Nero":
                filterToApply = PhotoEffectMono(inputImage: inputImage)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Noir":
                filterToApply = PhotoEffectNoir(inputImage: inputImage)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
                //            case "Vetrato":
                //                filterToApply = GlassDistortion(inputImage: inputImage, inputTexture: inputImage, inputCenter: CIVector(x:50.0, y:50.0), inputScale: 25.0)
                //                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            //                filteredImages.append(filteredImage)
            case "Patina":
                filterToApply = Bloom(inputImage: inputImage, inputRadius: 1.0, inputIntensity: 0.5)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
                //            case "Fumetto":
                //                filterToApply = ComicEffect(inputImage: inputImage)
                //                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
                //                filteredImages.append(filteredImage)
                //            case "Evoluzione":
                //                filterToApply = Convolution3X3(inputImage: inputImage, inputWeights: CIVector(string:"[0 0 0 0 1 0 0 0 0]"), inputBias: 0.0)
                //                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            //                filteredImages.append(filteredImage)
            case "Acquarello":
                filterToApply = Crystallize(inputImage: inputImage, inputRadius: 3.5, inputCenter: CIVector(x:150.0, y:150.0))
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Acceso":
                let image = UIImage(ciImage: inputImage)
                filterToApply = DepthOfField(inputImage: inputImage, inputPoint0: CIVector(x:image.size.width / 2, y: image.size.height / 2), inputPoint1: CIVector(x:220.0, y:220.0), inputSaturation: 1.5, inputUnsharpMaskRadius: 3.5, inputUnsharpMaskIntensity: 1.5, inputRadius: 10.0)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            case "Neon":
                filterToApply = Edges(inputImage: inputImage, inputIntensity: 7.0)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
                //            case "Tratto":
                //                filterToApply = EdgeWork(inputImage: inputImage, inputRadius: 3.0)
                //                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            //                filteredImages.append(filteredImage)
            case "Glow":
                filterToApply = Gloom(inputImage: inputImage, inputRadius: 2.0, inputIntensity: 0.5)
                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
                //            case "Matita":
                //                filterToApply = LineOverlay(inputImage: inputImage, inputNRNoiseLevel: 0.00, inputNRSharpness: 3.1, inputEdgeIntensity: 0.5, inputThreshold: 0.3, inputContrast: 80.0)
                //                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
                //                filteredImages.append(filteredImage)
                //            case "Puzzle":
                //                filterToApply = Pointillize(inputImage: inputImage, inputRadius: 3.5, inputCenter: CIVector(x: 150, y: 150))
                //                filteredImage = UIImage(ciImage: filterToApply.outputImage!)
            //                filteredImages.append(filteredImage)
            default:
                break
                //                filteredImage = UIImage(ciImage:inputImage)
                //                filteredImages.append(filteredImage)
            }
            
            UIGraphicsBeginImageContextWithOptions(filteredImage.size, true, 0);
            filteredImage.draw(at: CGPoint(x: 0, y: 0))
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            filteredImages.append(image!)
        }
        onSuccess()
    }
}
