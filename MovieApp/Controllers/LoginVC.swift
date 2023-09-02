//
//  LoginVC.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit
import FirebaseDatabase

class LoginVC: UIViewController {
    
    private let database = Database.database().reference()

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }

    
    @IBAction func btnLoginTapped(_ sender: Any) {
        
        if (tfUsername.text == "")  {
            ISGlobal.instance.toastMessage(view: view, message: "Please fill in account email address")
            return
        }
        else if (tfPassword.text == "") {
            ISGlobal.instance.toastMessage(view: view, message: "Please fill in password")
            return
        }
        
        if (tfUsername.text == "VVVBB" && tfPassword.text == "@bcd1234") {
            // hardcoded username and password
            UserDefaultsHelper.UserAccount.instance.userName = "VVVBB"
            UserDefaultsHelper.UserAccount.instance.userPassword = "@bcd1234"
            
            let vc: HomeVC = UIStoryboard.Main.homeVC() as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        let vc: SignUpVC = UIStoryboard.Main.signUpVC() as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
