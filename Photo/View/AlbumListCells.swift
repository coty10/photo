//
//  AlbumListCells.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 06/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit

class AlbumListCells: UITableViewCell {
    @IBOutlet weak var allPhotoImage: UIImageView!
    @IBOutlet weak var allPhotoTitle: UILabel!
    @IBOutlet weak var allPhotoCount: UILabel!
    @IBOutlet weak var collectionImage: UIImageView!
    @IBOutlet weak var collectionTitle: UILabel!
    @IBOutlet weak var collectionCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
