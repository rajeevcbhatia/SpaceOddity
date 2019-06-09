//
//  BaseViewController.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNotificationObservers()
    }
    
    func initNotificationObservers() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showRetryAlert(title: String, message: String, callback: @escaping (() -> ())) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.cancel) { (action) in
            callback()
        }
        alertController.addAction(retryAction)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
