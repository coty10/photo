//
//  PhotoFilters.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 13/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit
import CoreImage

public protocol Filter {
    /**
     A reference to the core image filter
     */
    var filter: CIFilter { get }
    /**
     The output of the filter.
     */
    var outputImage: CIImage? { get }
}

/**
 Code common to all filters.
 */
extension Filter {
    /**
     The output of the filter.
     */
    public var outputImage: CIImage? { return self.filter.outputImage }
}
/**
 Bloom
 - seealso:
 [CIBloom](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIBloom)
 */
public class Bloom: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIBloom filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the effect. The larger the radius, the greater the effect.
     - parameter inputIntensity: The intensity of the effect. A value of 0.0 is no effect. A value of 1.0 is the maximum effect.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 10.0, inputIntensity: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius,
            "inputIntensity":inputIntensity        ]
        guard let filter = CIFilter(name:"CIBloom", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Box Blur
 - seealso:
 [CIBoxBlur](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIBoxBlur)
 */
public class BoxBlur: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIBoxBlur filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 10.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIBoxBlur", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 CMYK Halftone
 - seealso:
 [CICMYKHalftone](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICMYKHalftone)
 */
public class CMYKHalftone: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CICMYKHalftone filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The x and y position to use as the center of the halftone pattern
     - parameter inputWidth: The distance between dots in the pattern.
     - parameter inputAngle: The angle of the pattern.
     - parameter inputSharpness: The sharpness of the pattern. The larger the value, the sharper the pattern.
     - parameter inputGCR: The gray component replacement value. The value can vary from 0.0 (none) to 1.0.
     - parameter inputUCR: The under color removal value. The value can vary from 0.0 to 1.0.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputWidth: CGFloat = 6.0, inputAngle: CGFloat = 0.0, inputSharpness: CGFloat = 0.7, inputGCR: CGFloat = 1.0, inputUCR: CGFloat = 0.5) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputWidth":inputWidth,
            "inputAngle":inputAngle,
            "inputSharpness":inputSharpness,
            "inputGCR":inputGCR,
            "inputUCR":inputUCR        ]
        guard let filter = CIFilter(name:"CICMYKHalftone", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Color Clamp
 - seealso:
 [CIColorClamp](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorClamp)
 */
public class ColorClamp: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIColorClamp filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputMinComponents: Lower clamping values
     - parameter inputMaxComponents: Higher clamping values
     */
    public init(inputImage: CIImage, inputMinComponents: CIVector = CIVector(x:0.0, y:0.0, z:0.0, w:0.0), inputMaxComponents: CIVector = CIVector(x:1.0, y:1.0, z:1.0, w:1.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputMinComponents":inputMinComponents,
            "inputMaxComponents":inputMaxComponents        ]
        guard let filter = CIFilter(name:"CIColorClamp", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}



/**
 Color Invert
 - seealso:
 [CIColorInvert](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorInvert)
 */
public class ColorInvert: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIColorInvert filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIColorInvert", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}


/**
 Color Monochrome
 - seealso:
 [CIColorMonochrome](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorMonochrome)
 */
public class ColorMonochrome: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIColorMonochrome filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputColor: The monochrome color to apply to the image.
     - parameter inputIntensity: The intensity of the monochrome effect. A value of 1.0 creates a monochrome image using the supplied color. A value of 0.0 has no effect on the image.
     */
    public init(inputImage: CIImage, inputColor: CIColor = CIColor(red:0.6, green:0.45, blue:0.3, alpha:1.0), inputIntensity: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputColor":inputColor,
            "inputIntensity":inputIntensity        ]
        guard let filter = CIFilter(name:"CIColorMonochrome", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}


/**
 Color Posterize
 - seealso:
 [CIColorPosterize](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorPosterize)
 */
public class ColorPosterize: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIColorPosterize filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputLevels: The number of brightness levels to use for each color component. Lower values result in a more extreme poster effect.
     */
    public init(inputImage: CIImage, inputLevels: CGFloat = 6.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputLevels":inputLevels        ]
        guard let filter = CIFilter(name:"CIColorPosterize", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}


/**
 Comic Effect
 - seealso:
 [CIComicEffect](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIComicEffect)
 */
public class ComicEffect: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIComicEffect filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIComicEffect", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}


/**
 3 by 3 convolution
 - seealso:
 [CIConvolution3X3](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIConvolution3X3)
 */
public class Convolution3X3: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIConvolution3X3 filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputWeights:
     - parameter inputBias:
     */
    public init(inputImage: CIImage, inputWeights: CIVector = CIVector(string:"[0 0 0 0 1 0 0 0 0]"), inputBias: CGFloat = 0.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputWeights":inputWeights,
            "inputBias":inputBias        ]
        guard let filter = CIFilter(name:"CIConvolution3X3", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Crystallize
 - seealso:
 [CICrystallize](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICrystallize)
 */
public class Crystallize: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CICrystallize filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the effect. The larger the radius, the larger the resulting crystals.
     - parameter inputCenter: The center of the effect as x and y coordinates.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 20.0, inputCenter: CIVector = CIVector(x:150.0, y:150.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius,
            "inputCenter":inputCenter        ]
        guard let filter = CIFilter(name:"CICrystallize", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Depth of Field
 - seealso:
 [CIDepthOfField](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIDepthOfField)
 */
public class DepthOfField: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIDepthOfField filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputPoint0:
     - parameter inputPoint1:
     - parameter inputSaturation: The amount to adjust the saturation.
     - parameter inputUnsharpMaskRadius:
     - parameter inputUnsharpMaskIntensity:
     - parameter inputRadius: The distance from the center of the effect.
     */
    public init(inputImage: CIImage, inputPoint0: CIVector = CIVector(x:0.0, y:300.0), inputPoint1: CIVector = CIVector(x:300.0, y:300.0), inputSaturation: CGFloat = 1.5, inputUnsharpMaskRadius: CGFloat = 2.5, inputUnsharpMaskIntensity: CGFloat = 0.5, inputRadius: CGFloat = 6.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputPoint0":inputPoint0,
            "inputPoint1":inputPoint1,
            "inputSaturation":inputSaturation,
            "inputUnsharpMaskRadius":inputUnsharpMaskRadius,
            "inputUnsharpMaskIntensity":inputUnsharpMaskIntensity,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIDepthOfField", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Disc Blur
 - seealso:
 [CIDiscBlur](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIDiscBlur)
 */
public class DiscBlur: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIDiscBlur filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 8.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIDiscBlur", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Edges
 - seealso:
 [CIEdges](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIEdges)
 */
public class Edges: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIEdges filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputIntensity: The intensity of the edges. The larger the value, the higher the intensity.
     */
    public init(inputImage: CIImage, inputIntensity: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputIntensity":inputIntensity        ]
        guard let filter = CIFilter(name:"CIEdges", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Edge Work
 - seealso:
 [CIEdgeWork](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIEdgeWork)
 */
public class EdgeWork: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIEdgeWork filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The thickness of the edges. The larger the value, the thicker the edges.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 3.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIEdgeWork", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Gaussian Blur
 - seealso:
 [CIGaussianBlur](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIGaussianBlur)
 */
public class GaussianBlur: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIGaussianBlur filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 10.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIGaussianBlur", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Glass Distortion
 - seealso:
 [CIGlassDistortion](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIGlassDistortion)
 */
public class GlassDistortion: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIGlassDistortion filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputTexture: A texture to apply to the source image.
     - parameter inputCenter: The center of the effect as x and y coordinates.
     - parameter inputScale: The amount of texturing of the resulting image. The larger the value, the greater the texturing.
     */
    public init(inputImage: CIImage, inputTexture: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputScale: CGFloat = 200.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputTexture":inputTexture,
            "inputCenter":inputCenter,
            "inputScale":inputScale        ]
        guard let filter = CIFilter(name:"CIGlassDistortion", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}
/**
 Gloom
 - seealso:
 [CIGloom](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIGloom)
 */
public class Gloom: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIGloom filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the effect. The larger the radius, the greater the effect.
     - parameter inputIntensity: The intensity of the effect. A value of 0.0 is no effect. A value of 1.0 is the maximum effect.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 10.0, inputIntensity: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius,
            "inputIntensity":inputIntensity        ]
        guard let filter = CIFilter(name:"CIGloom", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Line Overlay
 - seealso:
 [CILineOverlay](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILineOverlay)
 */
public class LineOverlay: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CILineOverlay filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputNRNoiseLevel: The noise level of the image (used with camera data) that gets removed before tracing the edges of the image. Increasing the noise level helps to clean up the traced edges of the image.
     - parameter inputNRSharpness: The amount of sharpening done when removing noise in the image before tracing the edges of the image. This improves the edge acquisition.
     - parameter inputEdgeIntensity: The accentuation factor of the Sobel gradient information when tracing the edges of the image. Higher values find more edges, although typically a low value (such as 1.0) is used.
     - parameter inputThreshold: This value determines edge visibility. Larger values thin out the edges.
     - parameter inputContrast: The amount of anti-aliasing to use on the edges produced by this filter. Higher values produce higher contrast edges (they are less anti-aliased).
     */
    public init(inputImage: CIImage, inputNRNoiseLevel: CGFloat = 0.07, inputNRSharpness: CGFloat = 0.71, inputEdgeIntensity: CGFloat = 1.0, inputThreshold: CGFloat = 0.1, inputContrast: CGFloat = 50.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputNRNoiseLevel":inputNRNoiseLevel,
            "inputNRSharpness":inputNRSharpness,
            "inputEdgeIntensity":inputEdgeIntensity,
            "inputThreshold":inputThreshold,
            "inputContrast":inputContrast        ]
        guard let filter = CIFilter(name:"CILineOverlay", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Line Screen
 - seealso:
 [CILineScreen](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILineScreen)
 */
public class LineScreen: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CILineScreen filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The x and y position to use as the center of the line screen pattern
     - parameter inputAngle: The angle of the pattern.
     - parameter inputWidth: The distance between lines in the pattern.
     - parameter inputSharpness: The sharpness of the pattern. The larger the value, the sharper the pattern.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputAngle: CGFloat = 0.0, inputWidth: CGFloat = 6.0, inputSharpness: CGFloat = 0.7) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputAngle":inputAngle,
            "inputWidth":inputWidth,
            "inputSharpness":inputSharpness        ]
        guard let filter = CIFilter(name:"CILineScreen", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Luminosity Blend Mode
 - seealso:
 [CILuminosityBlendMode](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILuminosityBlendMode)
 */
public class LuminosityBlendMode: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CILuminosityBlendMode filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CILuminosityBlendMode", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Masked Variable Blur
 - seealso:
 [CIMaskedVariableBlur](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMaskedVariableBlur)
 */
public class MaskedVariableBlur: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMaskedVariableBlur filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputMask:
     - parameter inputRadius: The distance from the center of the effect.
     */
    public init(inputImage: CIImage, inputMask: CIImage, inputRadius: CGFloat = 5.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputMask":inputMask,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIMaskedVariableBlur", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Mask to Alpha
 - seealso:
 [CIMaskToAlpha](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMaskToAlpha)
 */
public class MaskToAlpha: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMaskToAlpha filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIMaskToAlpha", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Maximum Component
 - seealso:
 [CIMaximumComponent](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMaximumComponent)
 */
public class MaximumComponent: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMaximumComponent filter
     - parameter inputImage: The image to process.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIMaximumComponent", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Maximum
 - seealso:
 [CIMaximumCompositing](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMaximumCompositing)
 */
public class MaximumCompositing: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMaximumCompositing filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CIMaximumCompositing", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Median
 - seealso:
 [CIMedianFilter](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMedianFilter)
 */
public class MedianFilter: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMedianFilter filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIMedianFilter", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Minimum Component
 - seealso:
 [CIMinimumComponent](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMinimumComponent)
 */
public class MinimumComponent: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMinimumComponent filter
     - parameter inputImage: The image to process.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIMinimumComponent", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Motion Blur
 - seealso:
 [CIMotionBlur](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMotionBlur)
 */
public class MotionBlur: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIMotionBlur filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius determines how many pixels are used to create the blur. The larger the radius, the blurrier the result.
     - parameter inputAngle: The angle of the motion determines which direction the blur smears.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 20.0, inputAngle: CGFloat = 0.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius,
            "inputAngle":inputAngle        ]
        guard let filter = CIFilter(name:"CIMotionBlur", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Photo Effect Chrome
 - seealso:
 [CIPhotoEffectChrome](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPhotoEffectChrome)
 */
public class PhotoEffectChrome: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIPhotoEffectChrome filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIPhotoEffectChrome", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Photo Effect Fade
 - seealso:
 [CIPhotoEffectFade](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPhotoEffectFade)
 */
public class PhotoEffectFade: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIPhotoEffectFade filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIPhotoEffectFade", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Photo Effect Mono
 - seealso:
 [CIPhotoEffectMono](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPhotoEffectMono)
 */
public class PhotoEffectMono: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIPhotoEffectMono filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIPhotoEffectMono", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Photo Effect Noir
 - seealso:
 [CIPhotoEffectNoir](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPhotoEffectNoir)
 */
public class PhotoEffectNoir: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIPhotoEffectNoir filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CIPhotoEffectNoir", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Pointillize
 - seealso:
 [CIPointillize](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPointillize)
 */
public class Pointillize: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIPointillize filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius of the circles in the resulting pattern.
     - parameter inputCenter: The x and y position to use as the center of the effect
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 20.0, inputCenter: CIVector = CIVector(x:150.0, y:150.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius,
            "inputCenter":inputCenter        ]
        guard let filter = CIFilter(name:"CIPointillize", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Sepia Tone
 - seealso:
 [CISepiaTone](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISepiaTone)
 */
public class SepiaTone: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISepiaTone filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputIntensity: The intensity of the sepia effect. A value of 1.0 creates a monochrome sepia image. A value of 0.0 has no effect on the image.
     */
    public init(inputImage: CIImage, inputIntensity: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputIntensity":inputIntensity        ]
        guard let filter = CIFilter(name:"CISepiaTone", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Shaded Material
 - seealso:
 [CIShadedMaterial](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIShadedMaterial)
 */
public class ShadedMaterial: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIShadedMaterial filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputShadingImage: The image to use as the height field. The resulting image has greater heights with lighter shades, and lesser heights (lower areas) with darker shades.
     - parameter inputScale: THe scale of the effect. The higher the value, the more dramatic the effect.
     */
    public init(inputImage: CIImage, inputShadingImage: CIImage, inputScale: CGFloat = 10.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputShadingImage":inputShadingImage,
            "inputScale":inputScale        ]
        guard let filter = CIFilter(name:"CIShadedMaterial", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Smooth Linear Gradient
 - seealso:
 [CISmoothLinearGradient](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISmoothLinearGradient)
 */
public class SmoothLinearGradient: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISmoothLinearGradient filter
     - parameter inputPoint0: The starting position of the gradient -- where the first color begins.
     - parameter inputPoint1: The ending position of the gradient -- where the second color begins.
     - parameter inputColor0: The first color to use in the gradient.
     - parameter inputColor1: The second color to use in the gradient.
     */
    public init(inputPoint0: CIVector = CIVector(x:0.0, y:0.0), inputPoint1: CIVector = CIVector(x:200.0, y:200.0), inputColor0: CIColor = CIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0), inputColor1: CIColor = CIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0)) {
        let parameters:[String : Any] = [
            "inputPoint0":inputPoint0,
            "inputPoint1":inputPoint1,
            "inputColor0":inputColor0,
            "inputColor1":inputColor1        ]
        guard let filter = CIFilter(name:"CISmoothLinearGradient", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Soft Light Blend Mode
 - seealso:
 [CISoftLightBlendMode](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISoftLightBlendMode)
 */
public class SoftLightBlendMode: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISoftLightBlendMode filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CISoftLightBlendMode", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Source Atop
 - seealso:
 [CISourceAtopCompositing](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceAtopCompositing)
 */
public class SourceAtopCompositing: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISourceAtopCompositing filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CISourceAtopCompositing", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Source In
 - seealso:
 [CISourceInCompositing](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceInCompositing)
 */
public class SourceInCompositing: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISourceInCompositing filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CISourceInCompositing", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Source Out
 - seealso:
 [CISourceOutCompositing](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceOutCompositing)
 */
public class SourceOutCompositing: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISourceOutCompositing filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CISourceOutCompositing", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Source Over
 - seealso:
 [CISourceOverCompositing](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceOverCompositing)
 */
public class SourceOverCompositing: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISourceOverCompositing filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CISourceOverCompositing", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Spot Color
 - seealso:
 [CISpotColor](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISpotColor)
 */
public class SpotColor: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISpotColor filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenterColor1: The center value of the first color range to replace.
     - parameter inputReplacementColor1: A replacement color for the first color range.
     - parameter inputCloseness1: A value that indicates how close the first color must match before it is replaced.
     - parameter inputContrast1: The contrast of the first replacement color.
     - parameter inputCenterColor2: The center value of the second color range to replace.
     - parameter inputReplacementColor2: A replacement color for the second color range.
     - parameter inputCloseness2: A value that indicates how close the second color must match before it is replaced.
     - parameter inputContrast2: The contrast of the second replacement color.
     - parameter inputCenterColor3: The center value of the third color range to replace.
     - parameter inputReplacementColor3: A replacement color for the third color range.
     - parameter inputCloseness3: A value that indicates how close the third color must match before it is replaced.
     - parameter inputContrast3: The contrast of the third replacement color.
     */
    public init(inputImage: CIImage, inputCenterColor1: CIColor = CIColor(red:0.0784, green:0.0627, blue:0.0706, alpha:1.0), inputReplacementColor1: CIColor = CIColor(red:0.4392, green:0.1922, blue:0.1961, alpha:1.0), inputCloseness1: CGFloat = 0.22, inputContrast1: CGFloat = 0.98, inputCenterColor2: CIColor = CIColor(red:0.5255, green:0.3059, blue:0.3451, alpha:1.0), inputReplacementColor2: CIColor = CIColor(red:0.9137, green:0.5608, blue:0.5059, alpha:1.0), inputCloseness2: CGFloat = 0.15, inputContrast2: CGFloat = 0.98, inputCenterColor3: CIColor = CIColor(red:0.9216, green:0.4549, blue:0.3333, alpha:1.0), inputReplacementColor3: CIColor = CIColor(red:0.9098, green:0.7529, blue:0.6078, alpha:1.0), inputCloseness3: CGFloat = 0.5, inputContrast3: CGFloat = 0.99) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenterColor1":inputCenterColor1,
            "inputReplacementColor1":inputReplacementColor1,
            "inputCloseness1":inputCloseness1,
            "inputContrast1":inputContrast1,
            "inputCenterColor2":inputCenterColor2,
            "inputReplacementColor2":inputReplacementColor2,
            "inputCloseness2":inputCloseness2,
            "inputContrast2":inputContrast2,
            "inputCenterColor3":inputCenterColor3,
            "inputReplacementColor3":inputReplacementColor3,
            "inputCloseness3":inputCloseness3,
            "inputContrast3":inputContrast3        ]
        guard let filter = CIFilter(name:"CISpotColor", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Spot Light
 - seealso:
 [CISpotLight](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISpotLight)
 */
public class SpotLight: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISpotLight filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputLightPosition: The x and y position of the spotlight.
     - parameter inputLightPointsAt: The x and y position that the spotlight points at.
     - parameter inputBrightness: The brightness of the spotlight.
     - parameter inputConcentration: The spotlight size. The smaller the value, the more tightly focused the light beam.
     - parameter inputColor: The color of the spotlight.
     */
    public init(inputImage: CIImage, inputLightPosition: CIVector = CIVector(x:400.0, y:600.0, z:150.0), inputLightPointsAt: CIVector = CIVector(x:200.0, y:200.0, z:0.0), inputBrightness: CGFloat = 3.0, inputConcentration: CGFloat = 0.1, inputColor: CIColor = CIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputLightPosition":inputLightPosition,
            "inputLightPointsAt":inputLightPointsAt,
            "inputBrightness":inputBrightness,
            "inputConcentration":inputConcentration,
            "inputColor":inputColor        ]
        guard let filter = CIFilter(name:"CISpotLight", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 sRGB Tone Curve to Linear
 - seealso:
 [CISRGBToneCurveToLinear](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISRGBToneCurveToLinear)
 */
public class SRGBToneCurveToLinear: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISRGBToneCurveToLinear filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     */
    public init(inputImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage        ]
        guard let filter = CIFilter(name:"CISRGBToneCurveToLinear", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Star Shine
 - seealso:
 [CIStarShineGenerator](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIStarShineGenerator)
 */
public class StarShineGenerator: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIStarShineGenerator filter
     - parameter inputCenter: The  x and y position to use as the center of the star.
     - parameter inputColor: The color to use for the outer shell of the circular star.
     - parameter inputRadius: The radius of the star.
     - parameter inputCrossScale: The size of the cross pattern.
     - parameter inputCrossAngle: The angle of the cross pattern.
     - parameter inputCrossOpacity: The opacity of the cross pattern.
     - parameter inputCrossWidth: The width of the cross pattern.
     - parameter inputEpsilon: The length of the cross spikes.
     */
    public init(inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputColor: CIColor = CIColor(red:1.0, green:0.8, blue:0.6, alpha:1.0), inputRadius: CGFloat = 50.0, inputCrossScale: CGFloat = 15.0, inputCrossAngle: CGFloat = 0.6, inputCrossOpacity: CGFloat = -2.0, inputCrossWidth: CGFloat = 2.5, inputEpsilon: CGFloat = -2.0) {
        let parameters:[String : Any] = [
            "inputCenter":inputCenter,
            "inputColor":inputColor,
            "inputRadius":inputRadius,
            "inputCrossScale":inputCrossScale,
            "inputCrossAngle":inputCrossAngle,
            "inputCrossOpacity":inputCrossOpacity,
            "inputCrossWidth":inputCrossWidth,
            "inputEpsilon":inputEpsilon        ]
        guard let filter = CIFilter(name:"CIStarShineGenerator", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Straighten
 - seealso:
 [CIStraightenFilter](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIStraightenFilter)
 */
public class StraightenFilter: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIStraightenFilter filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputAngle: An angle in radians.
     */
    public init(inputImage: CIImage, inputAngle: CGFloat = 0.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputAngle":inputAngle        ]
        guard let filter = CIFilter(name:"CIStraightenFilter", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Stretch Crop
 - seealso:
 [CIStretchCrop](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIStretchCrop)
 */
public class StretchCrop: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIStretchCrop filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputSize: The size in pixels of the output image.
     - parameter inputCropAmount: Determines if and how much cropping should be used to achieve the target size. If value is 0 then only stretching is used.  If 1 then only cropping is used.
     - parameter inputCenterStretchAmount: Determine how much the center of the image is stretched if stretching is used. If value is 0 then the center of the image maintains the original aspect ratio.  If 1 then the image is stretched uniformly.
     */
    public init(inputImage: CIImage, inputSize: CIVector = CIVector(x:1280.0, y:720.0), inputCropAmount: CGFloat = 0.25, inputCenterStretchAmount: CGFloat = 0.25) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputSize":inputSize,
            "inputCropAmount":inputCropAmount,
            "inputCenterStretchAmount":inputCenterStretchAmount        ]
        guard let filter = CIFilter(name:"CIStretchCrop", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Stripes
 - seealso:
 [CIStripesGenerator](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIStripesGenerator)
 */
public class StripesGenerator: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIStripesGenerator filter
     - parameter inputCenter: The x and y position to use as the center of the stripe pattern.
     - parameter inputColor0: A color to use for the odd stripes.
     - parameter inputColor1: A color to use for the even stripes.
     - parameter inputWidth: The width of a stripe.
     - parameter inputSharpness: The sharpness of the stripe pattern. The smaller the value, the more blurry the pattern. Values range from 0.0 to 1.0.
     */
    public init(inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputColor0: CIColor = CIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0), inputColor1: CIColor = CIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0), inputWidth: CGFloat = 80.0, inputSharpness: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputCenter":inputCenter,
            "inputColor0":inputColor0,
            "inputColor1":inputColor1,
            "inputWidth":inputWidth,
            "inputSharpness":inputSharpness        ]
        guard let filter = CIFilter(name:"CIStripesGenerator", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Subtract Blend Mode
 - seealso:
 [CISubtractBlendMode](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISubtractBlendMode)
 */
public class SubtractBlendMode: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISubtractBlendMode filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputBackgroundImage: The image to use as a background image.
     */
    public init(inputImage: CIImage, inputBackgroundImage: CIImage) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputBackgroundImage":inputBackgroundImage        ]
        guard let filter = CIFilter(name:"CISubtractBlendMode", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Sunbeams
 - seealso:
 [CISunbeamsGenerator](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISunbeamsGenerator)
 */
public class SunbeamsGenerator: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISunbeamsGenerator filter
     - parameter inputCenter: The  x and y position to use as the center of the sunbeam pattern
     - parameter inputColor: The color of the sun.
     - parameter inputSunRadius: The radius of the sun.
     - parameter inputMaxStriationRadius: The radius of the sunbeams.
     - parameter inputStriationStrength: The intensity of the sunbeams. Higher values result in more intensity.
     - parameter inputStriationContrast: The contrast of the sunbeams. Higher values result in more contrast.
     - parameter inputTime: The duration of the effect.
     */
    public init(inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputColor: CIColor = CIColor(red:1.0, green:0.5, blue:0.0, alpha:1.0), inputSunRadius: CGFloat = 40.0, inputMaxStriationRadius: CGFloat = 2.58, inputStriationStrength: CGFloat = 0.5, inputStriationContrast: CGFloat = 1.375, inputTime: CGFloat = 0.0) {
        let parameters:[String : Any] = [
            "inputCenter":inputCenter,
            "inputColor":inputColor,
            "inputSunRadius":inputSunRadius,
            "inputMaxStriationRadius":inputMaxStriationRadius,
            "inputStriationStrength":inputStriationStrength,
            "inputStriationContrast":inputStriationContrast,
            "inputTime":inputTime        ]
        guard let filter = CIFilter(name:"CISunbeamsGenerator", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Swipe
 - seealso:
 [CISwipeTransition](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISwipeTransition)
 */
public class SwipeTransition: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CISwipeTransition filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputTargetImage: The target image for a transition.
     - parameter inputExtent: The extent of the effect.
     - parameter inputColor: The color of the swipe.
     - parameter inputTime: The parametric time of the transition. This value drives the transition from start (at time 0) to end (at time 1).
     - parameter inputAngle: The angle of the swipe.
     - parameter inputWidth: The width of the swipe
     - parameter inputOpacity: The opacity of the swipe.
     */
    public init(inputImage: CIImage, inputTargetImage: CIImage, inputExtent: CIVector = CIVector(x:0.0, y:0.0, z:300.0, w:300.0), inputColor: CIColor = CIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0), inputTime: CGFloat = 0.0, inputAngle: CGFloat = 0.0, inputWidth: CGFloat = 300.0, inputOpacity: CGFloat = 0.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputTargetImage":inputTargetImage,
            "inputExtent":inputExtent,
            "inputColor":inputColor,
            "inputTime":inputTime,
            "inputAngle":inputAngle,
            "inputWidth":inputWidth,
            "inputOpacity":inputOpacity        ]
        guard let filter = CIFilter(name:"CISwipeTransition", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Temperature and Tint
 - seealso:
 [CITemperatureAndTint](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CITemperatureAndTint)
 */
public class TemperatureAndTint: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CITemperatureAndTint filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputNeutral:
     - parameter inputTargetNeutral:
     */
    public init(inputImage: CIImage, inputNeutral: CIVector = CIVector(x:6500.0, y:0.0), inputTargetNeutral: CIVector = CIVector(x:6500.0, y:0.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputNeutral":inputNeutral,
            "inputTargetNeutral":inputTargetNeutral        ]
        guard let filter = CIFilter(name:"CITemperatureAndTint", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Tone Curve
 - seealso:
 [CIToneCurve](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIToneCurve)
 */
public class ToneCurve: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIToneCurve filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputPoint0:
     - parameter inputPoint1:
     - parameter inputPoint2:
     - parameter inputPoint3:
     - parameter inputPoint4:
     */
    public init(inputImage: CIImage, inputPoint0: CIVector = CIVector(x:0.0, y:0.0), inputPoint1: CIVector = CIVector(x:0.25, y:0.25), inputPoint2: CIVector = CIVector(x:0.5, y:0.5), inputPoint3: CIVector = CIVector(x:0.75, y:0.75), inputPoint4: CIVector = CIVector(x:1.0, y:1.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputPoint0":inputPoint0,
            "inputPoint1":inputPoint1,
            "inputPoint2":inputPoint2,
            "inputPoint3":inputPoint3,
            "inputPoint4":inputPoint4        ]
        guard let filter = CIFilter(name:"CIToneCurve", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Torus Lens Distortion
 - seealso:
 [CITorusLensDistortion](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CITorusLensDistortion)
 */
public class TorusLensDistortion: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CITorusLensDistortion filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The x and y position to use as the center of the torus.
     - parameter inputRadius: The outer radius of the torus.
     - parameter inputWidth: The width of the ring.
     - parameter inputRefraction: The refraction of the glass.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputRadius: CGFloat = 160.0, inputWidth: CGFloat = 80.0, inputRefraction: CGFloat = 1.7) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputRadius":inputRadius,
            "inputWidth":inputWidth,
            "inputRefraction":inputRefraction        ]
        guard let filter = CIFilter(name:"CITorusLensDistortion", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Triangle Kaleidoscope
 - seealso:
 [CITriangleKaleidoscope](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CITriangleKaleidoscope)
 */
public class TriangleKaleidoscope: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CITriangleKaleidoscope filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputPoint:
     - parameter inputSize:
     - parameter inputRotation:
     - parameter inputDecay:
     */
    public init(inputImage: CIImage, inputPoint: CIVector = CIVector(x:150.0, y:150.0), inputSize: CGFloat = 700.0, inputRotation: CGFloat = 5.9242852965938, inputDecay: CGFloat = 0.85) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputPoint":inputPoint,
            "inputSize":inputSize,
            "inputRotation":inputRotation,
            "inputDecay":inputDecay        ]
        guard let filter = CIFilter(name:"CITriangleKaleidoscope", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Triangle Tile
 - seealso:
 [CITriangleTile](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CITriangleTile)
 */
public class TriangleTile: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CITriangleTile filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The x and y position to use as the center of the effect
     - parameter inputAngle: The angle (in radians) of the tiled pattern.
     - parameter inputWidth: The width of a tile.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputAngle: CGFloat = 0.0, inputWidth: CGFloat = 100.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputAngle":inputAngle,
            "inputWidth":inputWidth        ]
        guard let filter = CIFilter(name:"CITriangleTile", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Twelvefold Reflected Tile
 - seealso:
 [CITwelvefoldReflectedTile](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CITwelvefoldReflectedTile)
 */
public class TwelvefoldReflectedTile: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CITwelvefoldReflectedTile filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The x and y position to use as the center of the effect
     - parameter inputAngle: The angle (in radians) of the tiled pattern.
     - parameter inputWidth: The width of a tile.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputAngle: CGFloat = 0.0, inputWidth: CGFloat = 100.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputAngle":inputAngle,
            "inputWidth":inputWidth        ]
        guard let filter = CIFilter(name:"CITwelvefoldReflectedTile", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Twirl Distortion
 - seealso:
 [CITwirlDistortion](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CITwirlDistortion)
 */
public class TwirlDistortion: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CITwirlDistortion filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The center of the effect as x and y coordinates.
     - parameter inputRadius: The radius determines how many pixels are used to create the distortion. The larger the radius, wider the extent of the distortion.
     - parameter inputAngle: The angle (in radians) of the twirl. Values can be positive or negative.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputRadius: CGFloat = 300.0, inputAngle: CGFloat = 3.14159265358979) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputRadius":inputRadius,
            "inputAngle":inputAngle        ]
        guard let filter = CIFilter(name:"CITwirlDistortion", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Unsharp Mask
 - seealso:
 [CIUnsharpMask](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIUnsharpMask)
 */
public class UnsharpMask: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIUnsharpMask filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputRadius: The radius around a given pixel to apply the unsharp mask. The larger the radius, the more of the image is affected.
     - parameter inputIntensity: The intensity of the effect. The larger the value, the more contrast in the affected area.
     */
    public init(inputImage: CIImage, inputRadius: CGFloat = 2.5, inputIntensity: CGFloat = 0.5) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputRadius":inputRadius,
            "inputIntensity":inputIntensity        ]
        guard let filter = CIFilter(name:"CIUnsharpMask", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Vibrance
 - seealso:
 [CIVibrance](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIVibrance)
 */
public class Vibrance: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIVibrance filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputAmount: The amount to adjust the saturation.
     */
    public init(inputImage: CIImage, inputAmount: CGFloat = 0.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputAmount":inputAmount        ]
        guard let filter = CIFilter(name:"CIVibrance", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Vignette
 - seealso:
 [CIVignette](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIVignette)
 */
public class Vignette: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIVignette filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputIntensity: The intensity of the effect.
     - parameter inputRadius: The distance from the center of the effect.
     */
    public init(inputImage: CIImage, inputIntensity: CGFloat = 0.0, inputRadius: CGFloat = 1.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputIntensity":inputIntensity,
            "inputRadius":inputRadius        ]
        guard let filter = CIFilter(name:"CIVignette", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Vignette Effect
 - seealso:
 [CIVignetteEffect](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIVignetteEffect)
 */
public class VignetteEffect: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIVignetteEffect filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The center of the effect as x and y coordinates.
     - parameter inputRadius: The distance from the center of the effect.
     - parameter inputIntensity: The intensity of the effect.
     - parameter inputFalloff:
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputRadius: CGFloat = 150.0, inputIntensity: CGFloat = 1.0, inputFalloff: CGFloat = 0.5) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputRadius":inputRadius,
            "inputIntensity":inputIntensity,
            "inputFalloff":inputFalloff        ]
        guard let filter = CIFilter(name:"CIVignetteEffect", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Vortex Distortion
 - seealso:
 [CIVortexDistortion](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIVortexDistortion)
 */
public class VortexDistortion: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIVortexDistortion filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The center of the effect as x and y coordinates.
     - parameter inputRadius: The radius determines how many pixels are used to create the distortion. The larger the radius, wider the extent of the distortion.
     - parameter inputAngle: The angle (in radians) of the vortex.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputRadius: CGFloat = 300.0, inputAngle: CGFloat = 56.5486677646163) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputRadius":inputRadius,
            "inputAngle":inputAngle        ]
        guard let filter = CIFilter(name:"CIVortexDistortion", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 White Point Adjust
 - seealso:
 [CIWhitePointAdjust](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIWhitePointAdjust)
 */
public class WhitePointAdjust: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIWhitePointAdjust filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputColor: A color to use as the white point.
     */
    public init(inputImage: CIImage, inputColor: CIColor = CIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputColor":inputColor        ]
        guard let filter = CIFilter(name:"CIWhitePointAdjust", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

/**
 Zoom Blur
 - seealso:
 [CIZoomBlur](http://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIZoomBlur)
 */
public class ZoomBlur: Filter {
    /**
     A reference to the core image filter.
     */
    public let filter: CIFilter
    /**
     Creates a new CIZoomBlur filter
     - parameter inputImage: The image to use as an input image. For filters that also use a background image, this is the foreground image.
     - parameter inputCenter: The center of the effect as x and y coordinates.
     - parameter inputAmount: The zoom-in amount. Larger values result in more zooming in.
     */
    public init(inputImage: CIImage, inputCenter: CIVector = CIVector(x:150.0, y:150.0), inputAmount: CGFloat = 20.0) {
        let parameters:[String : Any] = [
            "inputImage":inputImage,
            "inputCenter":inputCenter,
            "inputAmount":inputAmount        ]
        guard let filter = CIFilter(name:"CIZoomBlur", withInputParameters: parameters) else { fatalError() }
        self.filter = filter
    }
}

