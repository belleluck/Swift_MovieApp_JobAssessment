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
        
        navigationItem.hidesBackButton = true
        let btnBack = UIButton(type: .system)
        btnBack.setImage(UIImage(systemName: "chevron.backward",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)), for: .normal)
        btnBack.setTitle("Back", for: .normal)
        btnBack.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .regular)
        btnBack.sizeToFit()
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
    }
    
    @objc func btnBackTapped(sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
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
        
        // if the user have fill in the username and password
        // and if match the database (in this example, hardcorded)
        if (tfUsername.text == "VVVBB" && tfPassword.text == "@bcd1234") {
            
            let cryptoHelper: CryptoHelper = CryptoHelper()
            let userPw: String = cryptoHelper.encryptPassword(plainText: tfPassword.text!)
            print("encrypted pw: \(userPw)")
            
//            let decryptedPW2 = cryptoHelper.decryptPassword(plainText: userPw)
//            print("decryptPassword pw: \(decryptedPW2)")
            
            UserDefaultsHelper.UserAccount.instance.userName = "VVVBB"
            UserDefaultsHelper.UserAccount.instance.userPassword = userPw
            
            let vc: HomeVC = UIStoryboard.Main.homeVC() as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            ISGlobal.instance.toastMessage(view: view, message: "Incorrect username or password")
        }
    }
    
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        let vc: SignUpVC = UIStoryboard.Main.signUpVC() as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
