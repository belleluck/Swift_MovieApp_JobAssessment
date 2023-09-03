//
//  ExtensionUtils.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit
import SQLite

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = [0, 1]
        gradient.borderColor = layer.borderColor
        gradient.borderWidth = layer.borderWidth
        gradient.cornerRadius = layer.cornerRadius
        gradient.opacity = 0.8
        layer.insertSublayer(gradient, at: 0)
        
        return gradient
    }
}

extension Connection {
    public var userVersion: Int {
        get {
            return Int(try! scalar("PRAGMA user_version") as! Int64)
        }
        set {
            try! run("PRAGMA user_version = \(newValue)")
        }
    }
}

extension UIImageView {
    //.scaleAspectFit
    @objc func downloadedMoviePosterFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            
            /// if have internet, convert image data to string, then save to database
            MovieDB.instance.updatePosterData(dataString: data.base64EncodedString(options: .init(rawValue: 0)))
            
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    //.scaleAspectFit
    @objc func downloadedMoviePosterFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedMoviePosterFrom(url: url, contentMode: mode)
    }
    
    @objc func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    
    @objc func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }

}

extension UIButton {
    
    func customActionButton(title: String, titleColor: UIColor, borderColor: UIColor, backgroundColor: UIColor) {
        
        //self.backgroundColor = buttBackColor
        //self.imageView?.backgroundColor = .red
        //self.titleLabel?.backgroundColor = .black
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17)
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        
        self.layer.backgroundColor = backgroundColor.cgColor
        
    }
    
}

