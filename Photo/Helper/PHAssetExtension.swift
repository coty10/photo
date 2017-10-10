//
//  PHAssetExtension.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 05/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import Foundation
import  Photos

extension PHAsset {
    func getURL(onSuccess: @escaping ((_ responseURL: URL?) -> Void)) {
        if self.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput: PHContentEditingInput?, info: [AnyHashable:Any]) -> Void in
                onSuccess(contentEditingInput!.fullSizeImageURL as URL?)
            })
        } else if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info:[AnyHashable:Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    onSuccess(localVideoUrl)
                } else {
                    onSuccess(nil)
                }
            })
        }
    }
    func generateThumnail(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: 100, height: 100)
        let time = CMTimeMake(2, 30)
        
        if let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil) {
            return UIImage(cgImage: img)
        }
        return nil
    }
    
}

