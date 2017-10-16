//
//  ApplyFilterVC.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 11/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage
import CoreGraphics


class ApplyFilterVC: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var imageToFilter: UIImageView!
    @IBOutlet weak var containerVideoView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var filtersScrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: Public Properties
    var croppedImage:UIImage!
    var videoUrlPassed: URL!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideo = false
    var filteredImagesArray = [UIImage]()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        playButton.isHidden = true
        containerVideoView.isHidden = true
        
        let tapVideo = UITapGestureRecognizer(target: self, action: #selector(tapToPause))
        tapVideo.numberOfTapsRequired = 1
        containerVideoView.addGestureRecognizer(tapVideo)
        
        viewConfigurations()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let image = self.originalImage.image
        
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            let size = CGSize(width: 30, height: 30)
            let inputImage = CIImage(image: (image?.imageScaledToSize(size: size, isOpaque: true))!)!
            filteredImages.createImageArray(inputImage: inputImage) {
                self?.filteredImagesArray = filteredImages.filteredImages
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: handle orientation
    
    // Handle notification
    @objc func onDidBecomeActive() {
        setOrientationPortarait()
    }
    // Change orientation to portarit
    private func setOrientationPortarait() {
        if UIDevice.current.orientation.isLandscape {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey:"orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
    // Only allow portarait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // MARK: Private Functions
    
    private func viewConfigurations(){
        if isVideo {
            self.createVideoPlayer(url: videoUrlPassed!)
            self.containerVideoView.isHidden = false
            self.playButton.isHidden = false
        } else {
            originalImage.image = croppedImage
            self.containerVideoView.isHidden = true
            self.playButton.isHidden = true
        }
    }
    
    //MARK: Custom Func
    @objc func tapToPause() {
        if player.timeControlStatus == .playing {
            player.pause()
            playButton.isHidden = false
        } else {
            player.play()
            playButton.isHidden = true
        }
    }
    func createVideoPlayer(url: URL) {
        self.containerVideoView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer.frame = containerVideoView.bounds
        self.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.containerVideoView.layer.insertSublayer(playerLayer, at: 0)
    }
    
    //MARK: Func to create an array of filtered Images and Filter Name
    
    //    func createFilteredArray(index: Int, inputImage: CIImage, onSuccess: @escaping (_ array: [UIImage], _ arrayNames: [String]) -> Void) {
    //        var filter: Filter!
    //        switch Filters(rawValue: index)! {
    //        case .Seppia:
    //            filter = SepiaTone(inputImage: inputImage, inputIntensity: 0.7)
    //            print(UIImage(ciImage: filter.outputImage!))
    //            filteredImage.append(UIImage(ciImage: filter.outputImage!))
    //            filterNameArray.append("Seppia")
    //        case .Mono:
    //            filter = ColorMonochrome(inputImage: inputImage, inputColor: CIColor.blue, inputIntensity: 0.5)
    //            filteredImage.append(UIImage(ciImage: filter.outputImage!))
    //            filterNameArray.append("Fredda")
    //        }
    //        onSuccess(filteredImage, filterNameArray)
    //
    //    }
    
    
    //MARK: Button Action
    
    @IBAction func forwardBtnPressed(_ sender: Any) {
    }
    @IBAction func playButtonPressed(_ sender: Any) {
        player.play()
        playButton.isHidden = true
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: CollectionView

extension ApplyFilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = filteredImagesArray.count
        if count == 0 {
            collectionView.isHidden = true
            activityIndicator.startAnimating()
        } else {
            collectionView.isHidden = false
            activityIndicator.stopAnimating()
        }
        return count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        
        cell.filteredImage.image = filteredImagesArray[indexPath.row]
        cell.filterName.text = filteredImages.filterNames[indexPath.row]
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
}
extension ApplyFilterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let size = filteredImagesArray[indexPath.row].size.applying(CGAffineTransform(scaleX: 1.5, y: 1.5))
        let selectedImage = filteredImagesArray[indexPath.row].imageScaledToSize(size: size, isOpaque: true)
        originalImage.image = selectedImage
    }
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resizedTo1MB() -> UIImage? {
        guard let imageData = UIImagePNGRepresentation(self) else { return nil }
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1024.0
        
        while imageSizeKB > 1024 {
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = UIImagePNGRepresentation(resizingImage)
                else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1024.0
        }
        
        return resizingImage
    }
    func imageScaledToSize(size : CGSize, isOpaque : Bool) -> UIImage{
        
        // begin a context of the desired size
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0.0)
        
        // draw image in the rect with zero origin and size of the context
        let imageRect = CGRect(origin: .zero, size: size)
        self.draw(in: imageRect)
        
        // get the scaled image, close the context and return the image
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

