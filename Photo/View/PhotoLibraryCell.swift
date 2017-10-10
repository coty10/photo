//
//  PhotoLibraryCell.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 03/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit

class PhotoLibraryCell: UICollectionViewCell {
    @IBOutlet weak var photoFromLibrary: UIImageView!
    @IBOutlet weak var videoDurationLbl: UILabel!
    @IBOutlet weak var selectedViewCellBG: UIView!
    
    var representedAssetIdentifier: String!
}

