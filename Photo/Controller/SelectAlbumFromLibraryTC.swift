//
//  SelectAlbumFromLibraryTC.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 06/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit
import Photos

class SelectAlbumFromLibraryTC: UITableViewController {
    @IBOutlet weak var headerBtn: UIButton!
    
    var photoThumbnail = UIImage(named:"NoImage")
    var headTitle: String!
    
    // MARK: Types for managing sections, cell and segue identifiers
    enum Section: Int {
        case allPhotos = 0
        case smartAlbums
        case userCollections
        
        static let count = 3
    }
    enum CellIdentifier: String {
        case allPhotos, collection
    }
    
    enum SegueIdentifier: String {
        case showAllPhotos
        case showCollection
    }
    
    // MARK: Properties
    var assetCollection = PHAssetCollection()
    var allPhotos: PHFetchResult<PHAsset>!
    var allPhotosFromAlbum = PHFetchResult<PHAsset>()
    var smartAlbums: PHFetchResult<PHAssetCollection>!
    var userCollections: PHFetchResult<PHAssetCollection>!
    let sectionLocalizedTitles = ["", NSLocalizedString("Smart Albums", comment: ""), NSLocalizedString("Albums", comment: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a PHFetchResult object for each section in the table view.
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "estimatedAssetCount > 0")
        smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: options)
        //        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        userCollections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options)
        
        
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        headerBtn.setTitle(headTitle, for: .normal)
        print(headTitle)
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? AddPhotoPostVC
            else { fatalError("unexpected view controller for segue") }
        guard let cell = sender as? AlbumListCells else { fatalError("unexpected cell for segue") }
        
        switch SegueIdentifier(rawValue: segue.identifier!)! {
        case .showAllPhotos:
            destination.fetchResult = allPhotos
            destination.headerTitleBtnString = cell.allPhotoTitle.text!
        case .showCollection:
            
            // get the asset collection for the selected row
            let indexPath = tableView.indexPath(for: cell)!
            let collection: PHCollection
            switch Section(rawValue: indexPath.section)! {
            case .smartAlbums:
                collection = smartAlbums.object(at: indexPath.row)
            case .userCollections:
                collection = userCollections.object(at: indexPath.row)
            default: return // not reached; all photos section already handled by other segue
            }
            
            // configure the view controller with the asset collection
            guard let assetCollection = collection as? PHAssetCollection
                else { fatalError("expected asset collection") }
            destination.fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
            destination.assetCollection = assetCollection
            destination.headerTitleBtnString = cell.collectionTitle.text!
            destination.isComingFromSelectAlbum = true
        }
    }
    
    
    // MARK: Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .allPhotos: return 1
        case .smartAlbums: return smartAlbums.count
        case .userCollections: return userCollections.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .allPhotos:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.allPhotos.rawValue, for: indexPath) as! AlbumListCells
            cell.allPhotoTitle.text = NSLocalizedString("All Photos", comment: "")
            cell.allPhotoImage.image = getAssetThumbnail(asset: allPhotos.lastObject!)
            cell.allPhotoCount.text = "\(allPhotos.count)"
            return cell
            
        case .smartAlbums:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.collection.rawValue, for: indexPath) as! AlbumListCells
            let collection = smartAlbums[indexPath.row]
            let photoFromCollection = PHAsset.fetchKeyAssets(in: collection, options: nil)
            if photoFromCollection?.count != 0 && photoFromCollection?.lastObject != nil {
                photoThumbnail = getAssetThumbnail(asset: (photoFromCollection?.lastObject)!)
                cell.collectionImage.image = photoThumbnail
            }
            cell.collectionTitle.text = collection.localizedTitle
            cell.collectionCount.text = "\(photoFromCollection?.count ?? 0)"
            
            return cell
            
        case .userCollections:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.collection.rawValue, for: indexPath) as! AlbumListCells
            let collection = userCollections.object(at: indexPath.row)
            let photoFromUserCollection = PHAsset.fetchKeyAssets(in: collection, options: nil)
            if photoFromUserCollection?.lastObject != nil {
                photoThumbnail = self.getAssetThumbnail(asset: (photoFromUserCollection?.lastObject)!)
            }
            cell.collectionTitle.text = collection.localizedTitle
            cell.collectionImage.image = photoThumbnail
            cell.collectionCount.text = "\(photoFromUserCollection?.count ?? 0)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionLocalizedTitles[section]
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    @IBAction func headerBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}// End of class

