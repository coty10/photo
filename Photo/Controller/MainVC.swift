//
//  MainVC.swift
//  Photo
//
//  Created by Marco Cotugno on 10/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goToPhoto(_ sender: Any) {
        RequestPermission.requestAccessPhotoLibraryPersmission(onSuccess: {
            self.presentingController()
        })
    }
    
func presentingController() {
    let showItemNavController = storyboard?.instantiateViewController(withIdentifier: "addPhotoVCNav") as! UINavigationController

    self.present(showItemNavController, animated: true, completion: nil)
}
    

}
