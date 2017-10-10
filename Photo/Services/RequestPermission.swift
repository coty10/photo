//
//  RequestPermission.swift
//  AquariumNote
//
//  Created by Marco Cotugno on 04/10/17.
//  Copyright © 2017 Marco Cotugno. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class RequestPermission {
    
    static func requestAccessCameraPersmission(onSuccess: @escaping () -> Void) {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .denied:
            alertToEncourageCameraAccess(title: "Abilita Accesso alla Fotocamera", msg: "Per poter scattare foto da condividere Aquarium Advisor deve poter accedere alla tua fotocamera. Per favore consenti l'accesso.")
        case .authorized:
            onSuccess()
        case .restricted: break
            
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    onSuccess()
                } else {
                    alertToEncourageCameraAccess(title: "Abilita Accesso alla Fotocamera", msg: "Per poter scattare foto da condividere Aquarium Advisor deve poter accedere alla tua fotocamera. Per favore consenti l'accesso.")
                }
            }
        }
    }
    static func alertToEncourageCameraAccess(title: String, msg: String) {
        let alertController = UIAlertController (title: title, message: msg, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Impostazioni", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Annulla", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    static func requestAccessPhotoLibraryPersmission(onSuccess: @escaping () -> Void ) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            onSuccess()
            
        } else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
            self.alertToEncouragePhotoLibraryAccess(title: "Abilita Accesso alle foto", msg: "Per poter condividere le tue foto Aquarium Advisor deve poter accedere alla tua libreria foto. Per favore consenti l'accesso.")
        } else if (status == PHAuthorizationStatus.notDetermined) {
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    //success
                    onSuccess()
                }
                else {
                    self.alertToEncouragePhotoLibraryAccess(title: "Abilita Accesso alle foto", msg: "Per poter condividere le tue foto Aquarium Advisor deve poter accedere alla tua libreria foto. Per favore consenti l'accesso.")
                }
            })
            
        } else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
    
    static func alertToEncouragePhotoLibraryAccess(title: String, msg: String) {
        let alertController = UIAlertController (title: title, message: msg, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Impostazioni", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Annulla", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}

extension UIApplication {
    
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

