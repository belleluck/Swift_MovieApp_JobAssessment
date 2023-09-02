//
//  ViewController.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit

class WelcomeAppVC: UIViewController {
    
    
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if (UserDefaultsHelper.UserAccount.instance.userName != "" && UserDefaultsHelper.UserAccount.instance.userPassword != "") {
            print("have user record")
            
            let vc: HomeVC = UIStoryboard.Main.homeVC() as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        let vc: LoginVC = UIStoryboard.Main.loginVC() as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        let vc: SignUpVC = UIStoryboard.Main.signUpVC() as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

