//
//  StoryboardConstant.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit

//struct StoryboardConstant {
//
//    struct Main {
//        static let BoardNmae = "Main"
//
//        static let welcomeVC = "WelcomeVC"
//        static let loginVC = "LoginVC"
//        static let signUpVC = "SignUpVC"
//        static let homeVC = "HomeVC"
//    }
//
//}
//
//let vc:UIViewController = UIStoryboard(name: StoryboardConstant.Main.BoardNmae, bundle: nil).instantiateViewController(withIdentifier: StoryboardConstant.Main.welcomeVC) as UIViewController
//self.navigationController?.pushViewController(vc, animated: true)

protocol StoryboardScene: RawRepresentable {
    
    static var storyboardName: String {
        get
    }
}

extension StoryboardScene {
    
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue as! String)
    }
}

extension UIStoryboard {
    
    struct Main {
        private enum Identifier: String, StoryboardScene {
            static let storyboardName: String = "Main"
            case WelcomeVC = "WelcomeVC"
            case LoginVC = "LoginVC"
            case SignUpVC = "SignUpVC"
            case HomeVC = "HomeVC"
        }
        
        static func welcomeVC() -> UIViewController {
            return Identifier.WelcomeVC.viewController()
        }
        
        static func loginVC() -> UIViewController {
            return Identifier.LoginVC.viewController()
        }
        
        static func signUpVC() -> UIViewController {
            return Identifier.SignUpVC.viewController()
        }
        
        static func homeVC() -> UIViewController {
            return Identifier.HomeVC.viewController()
        }
    }
    
    struct Movie {
        private enum Identifier: String, StoryboardScene {
            static let storyboardName: String = "Movie"
            case MovieListVC = "MovieListVC"
            case MovieDetailVC = "MovieDetailVC"
        }
        
        static func movieListVC() -> UIViewController {
            return Identifier.MovieListVC.viewController()
        }
        
        static func movieDetailVC() -> UIViewController {
            return Identifier.MovieDetailVC.viewController()
        }
    }
    
}

