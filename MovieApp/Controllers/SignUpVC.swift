//
//  SignUpVC.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit
import FirebaseDatabase

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var viewConfirmPwd: UIView!
    @IBOutlet weak var tfConfirmPwd: UITextField!
    
    @IBOutlet weak var viewBtnSignUp: UIView!
    
    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


    @IBAction func btnSignUpTapped(_ sender: Any) {
        print("btn Signup tapped")
//        if (tfName.text == "")  {
//            ISGlobal.instance.toastMessage(view: view, message: "Please fill in your name")
//            return
//        }
//        else if (tfEmail.text == "")  {
//            ISGlobal.instance.toastMessage(view: view, message: "Please fill in account email address")
//            return
//        }
//        else if (tfPassword.text == "") {
//            ISGlobal.instance.toastMessage(view: view, message: "Please fill in password")
//            return
//        }
//        else if (tfPassword.text == "") {
//            ISGlobal.instance.toastMessage(view: view, message: "Please fill in password again to confirm")
//            return
//        }
//
//        // tfEmail shouldn't be the child content
//        database.child(tfName.text!).observeSingleEvent(of: .value, with: { [self] snapshot in
//            guard let value = snapshot.value as? [String: Any] else {
//                ISGlobal.instance.toastMessage(view: self.view, message: "Proceed to create new account for user")
//
//                let object: [String: Any] = [
//                    "username": tfName.text!,
//                    "email": tfEmail.text!,
//                    "password": tfPassword.text!
//                ]
//
//                database.child(tfName.text!).setValue(object)
//                print("Successfully add new user")
//
//                return
//            }
//
//            if value.isEmpty {
//                print("value is empty")
//            }
//            else if (value["username"] as! String != "" && value["username"] != nil) {
//                print("got match user")
//                print(value)
//            }
//            else {
//                // add new user
//                print("Successfully add new user")
//
//
//                let object: [String: Any] = [
//                    "username": tfName.text!,
//                    "email": tfEmail.text!,
//                    "password": tfPassword.text!
//                ]
//
//                database.child(tfName.text!).setValue(object)
//                ISGlobal.instance.toastMessage(view: self.view, message: "New account created")
//            }
//
//        })
    }
    
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        let vc: LoginVC = UIStoryboard.Main.loginVC() as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
