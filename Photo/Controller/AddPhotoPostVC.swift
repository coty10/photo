//
//  AddPhotoPostVC.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 03/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit
import Photos
import AVKit

class AddPhotoPostVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerVideoView: UIView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var enlargeBtn: UIButton!
    @IBOutlet weak var headerTitleBtn: UIButton!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var scrollViewImage: FAScrollView!
    
    
    var imageToPass: UIImage!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var selectedCellView: UIView!
    var headerTitleBtnString = "Tutte le foto"
    var isComingFromSelectAlbum = false
    
    fileprivate let imageManager = PHCachingImageManager()
    var fetchResult: PHFetchResult<PHAsset>!
    var assetCollection: PHAssetCollection!
    var imageViewToDrag: UIImageView!
    var indexPathOfImageViewToDrag: IndexPath!
    var cellWidth = CGFloat()
    
    // MARK: Private Properties
    private let imageLoader = FAImageLoader()
    private var croppedImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellWidth = collectionView.bounds.size.width
        
        selectedCellView = UIView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width / 4, height: collectionView.bounds.width / 4))
        selectedCellView.backgroundColor = UIColor.white
        selectedCellView.alpha = 0.6
        selectedCellView.tag = 300
        
        forwardBtn.isEnabled = false
        playBtn.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onDidBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        tabBar.selectedItem = tabBar.items![0] as UITabBarItem
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
        }
        configureImageCropper(assets: fetchResult)
        let firstAsset = fetchResult[0]
        if firstAsset.mediaType == .video {
            firstAsset.getURL(onSuccess: { (videoUrl) in
                DispatchQueue.main.async {
                    self.createVideoPlayer(url: videoUrl!)
                    self.containerVideoView.isHidden = false
                }
            })
            playBtn.isHidden = false
        } else if firstAsset.mediaType == .image {
            playBtn.isHidden = true
            self.containerVideoView.isHidden = true
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddPhotoPostVC.tapToZoom))
        tap.numberOfTapsRequired = 2
        scrollViewImage.addGestureRecognizer(tap)
        
        let tapVideo = UITapGestureRecognizer(target: self, action: #selector(tapToPause))
        tapVideo.numberOfTapsRequired = 1
        containerVideoView.addGestureRecognizer(tapVideo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        headerTitleBtn.setTitle(headerTitleBtnString, for: .normal)
        headerTitleBtn.titleLabel?.minimumScaleFactor = 0.5
        headerTitleBtn.titleLabel?.numberOfLines = 2
    }
    private func configureImageCropper(assets:PHFetchResult<PHAsset>){
        
        if fetchResult.count != 0{
            fetchResult = assets
            collectionView.reloadData()
            selectDefaultImage()
        }
    }
    private func selectDefaultImage(){
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        selectImageFromAssetAtIndex(index: 0)
    }
    private func captureVisibleRect() -> UIImage{
        var croprect = CGRect.zero
        let xOffset = (scrollViewImage.imageToDisplay?.size.width)! / scrollViewImage.contentSize.width;
        let yOffset = (scrollViewImage.imageToDisplay?.size.height)! / scrollViewImage.contentSize.height;
        
        croprect.origin.x = scrollViewImage.contentOffset.x * xOffset;
        croprect.origin.y = scrollViewImage.contentOffset.y * yOffset;
        
        let normalizedWidth = (scrollViewImage?.frame.width)! / (scrollViewImage?.contentSize.width)!
        let normalizedHeight = (scrollViewImage?.frame.height)! / (scrollViewImage?.contentSize.height)!
        
        croprect.size.width = scrollViewImage.imageToDisplay!.size.width * normalizedWidth
        croprect.size.height = scrollViewImage.imageToDisplay!.size.height * normalizedHeight
        
        let toCropImage = scrollViewImage.imageView.image?.fixImageOrientation()
        let cr: CGImage? = toCropImage?.cgImage?.cropping(to: croprect)
        let cropped = UIImage(cgImage: cr!)
        
        return cropped
    }
    private func isSquareImage() -> Bool{
        let image = scrollViewImage.imageToDisplay
        if image?.size.width == image?.size.height { return true }
        else { return false }
    }
    // MARK: Public Functions
    
    func selectImageFromAssetAtIndex(index: Int){
        let asset = fetchResult.object(at: index)
        let size = scrollViewImage.frame.size.width
        
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: size, height: size), contentMode: .aspectFill, options: nil, resultHandler: { (image, info) in
            DispatchQueue.main.async {
                self.displayImageInScrollView(image: image!)
            }
        })
    }
    func displayImageInScrollView(image:UIImage){
        self.scrollViewImage.imageToDisplay = image
        if isSquareImage() { enlargeBtn.isHidden = true }
        else { enlargeBtn.isHidden = false }
    }
    func replicate(_ image:UIImage) -> UIImage? {
        
        guard let cgImage = image.cgImage?.copy() else {
            return nil
        }
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
    func handleLongPressGesture(recognizer: UILongPressGestureRecognizer) {
        
        let location = recognizer.location(in: view)
        
        if recognizer.state == .began {
            
            let cell: PhotoLibraryCell = recognizer.view as! PhotoLibraryCell
            indexPathOfImageViewToDrag = collectionView.indexPath(for: cell)
            imageViewToDrag = UIImageView(image: replicate(cell.photoFromLibrary.image!))
            imageViewToDrag.frame = CGRect(x: location.x - cellWidth/2, y: location.y - cellWidth/2, width: cellWidth, height: cellWidth)
            view.addSubview(imageViewToDrag!)
            view.bringSubview(toFront: imageViewToDrag!)
        }
        else if recognizer.state == .ended {
            
            if scrollViewImage.frame.contains(location) {
                collectionView.selectItem(at: indexPathOfImageViewToDrag, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
                selectImageFromAssetAtIndex(index: indexPathOfImageViewToDrag.item)
            }
            imageViewToDrag.removeFromSuperview()
            imageViewToDrag = nil
            indexPathOfImageViewToDrag = nil
        }
        else{
            imageViewToDrag.center = location
        }
    }
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
    func createVideoPlayer(url: URL) {
        self.containerVideoView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer.frame = containerVideoView.bounds
        self.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.containerVideoView.layer.insertSublayer(playerLayer, at: 0)
    }
    @objc func tapToZoom() {
        scrollViewImage.tapToZoom()
    }
    @objc func tapToPause() {
        if player.timeControlStatus == .playing {
            player.pause()
            playBtn.isHidden = false
        } else {
            player.play()
            playBtn.isHidden = true
        }
    }
    //MARK ColletionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]
        let asset = fetchResult.object(at: indexPath.item)
        
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String("PhotoLibraryCell"), for: indexPath) as? PhotoLibraryCell
            else { fatalError("unexpected cell in collection view") }
        cell.selectedViewCellBG.isHidden = true
        cell.selectedViewCellBG.alpha = 0
        if (indexPath.row == 0) {
            cell.addSubview(selectedCellView)
        }
        // Add a badge for duration to the cell if the PHAsset represents a video.
        let videoDuration = formatter.string(from: (asset.duration))
        if asset.mediaType == .video {
            cell.videoDurationLbl.isHidden = false
            cell.videoDurationLbl.text = videoDuration
        } else {
            cell.videoDurationLbl.isHidden = true
        }
        cell.representedAssetIdentifier = asset.localIdentifier
        let width = collectionView.bounds.width / 4
        imageManager.requestImage(for: asset, targetSize: CGSize(width: width, height: width), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            // The cell may have been recycled by the time this handler gets called;
            // set the cell's thumbnail image only if it's still showing the same asset.
            if cell.representedAssetIdentifier == asset.localIdentifier && image != nil {
                cell.photoFromLibrary.image = image
            }
        })
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 4
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.addSubview(selectedCellView)
        let asset = fetchResult[indexPath.row]
        if asset.mediaType == .video {
            asset.getURL(onSuccess: { (videoUrl) in
                DispatchQueue.main.async {
                    self.createVideoPlayer(url: videoUrl!)
                    self.containerVideoView.isHidden = false
                }
            })
            playBtn.isHidden = false
        } else if asset.mediaType == .image {
            playBtn.isHidden = true
            self.containerVideoView.isHidden = true
            if player != nil {
                player.pause()
            }
        }
        selectImageFromAssetAtIndex(index: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let viewWithTag = self.view.viewWithTag(300) {
            viewWithTag.removeFromSuperview()
        }
    }
    @IBAction func playBtnPressed(_ sender: Any) {
        player.play()
        playBtn.isHidden = true
    }
    @IBAction func enlargeBtnPressed(_ sender: Any) {
        scrollViewImage.zoom()
        if scrollViewImage.zoomScale <= 1 {
            if playerLayer != nil {
                self.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
            }
        } else {
            if playerLayer != nil {
                self.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            }
        }
    }
    @IBAction func undoBtnPressed(_ sender: Any) {
        if isComingFromSelectAlbum {
            presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "selectAlbums" {
            if let destination = segue.destination as? UINavigationController {
                if let targetController = destination.topViewController as? SelectAlbumFromLibraryTC {
                    targetController.headTitle = headerTitleBtnString
                }
            }
        }
    }
    @IBAction func forwardBtnPressed(_ sender: Any) {
        
    }
}
