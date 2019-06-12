//
//  Base.swift
//  History-Project-ios
//
//  Created by baby1234 on 28/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation 
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String, style: UIAlertController.Style = .alert, cancelIsPresent: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "네", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        if cancelIsPresent {
            alert.addAction(okAction)
            alert.addAction(cancelAction)
        } else {
            alert.addAction(okAction)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(msg: String, fun: (() -> Void)? = nil){
        let toast = UILabel(frame: CGRect(x: 32, y: 128, width: view.frame.size.width - 64, height: 42))
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toast.textColor = UIColor.white
        toast.text = msg
        toast.textAlignment = .center
        toast.layer.cornerRadius = 8
        toast.clipsToBounds = true
        toast.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        view.addSubview(toast)
        UIView.animate(withDuration: 0.2, delay: 0.8, options: .curveEaseOut, animations: {
            toast.alpha = 0.5
        }, completion: { _ in
            toast.removeFromSuperview()
            fun?()
        })
    }
}
