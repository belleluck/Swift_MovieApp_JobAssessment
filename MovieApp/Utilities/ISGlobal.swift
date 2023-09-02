//
//  ISGlobal.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit
import Toast_Swift

class ISGlobal {
    
    static let instance = ISGlobal()
    
    static let toastMessageDuration: Double = 2.0
    
    var overlay: UIView = UIView()
    
    func displayLoadingScreen(vc: UIViewController) {
        overlay = UIView()
        
        overlay = UIView(frame: vc.view.frame)
        overlay.backgroundColor = .lightGray
        overlay.alpha = 0.7
        
        let loadingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 160))
        loadingView.center = overlay.center
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 16
        
        let imageView: UIImageView = UIImageView(image: UIImage(named: "please_wait"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        imageView.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height * 0.3)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.color = .white
        loadingIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height * 0.75)
        loadingIndicator.startAnimating()
        
        loadingView.addSubview(loadingIndicator)
        loadingView.addSubview(imageView)
        overlay.addSubview(loadingView)
        vc.view.addSubview(overlay)
    }
    
    func removeLoadingScreen() {
        overlay.removeFromSuperview()
    }
    
    func toastMessage(view: UIView, message: String) {
        view.makeToast(message, duration: ISGlobal.toastMessageDuration, position: .center)
    }
}
