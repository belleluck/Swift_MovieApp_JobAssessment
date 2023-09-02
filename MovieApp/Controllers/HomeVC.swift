//
//  HomeVC.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        navigationItem.hidesBackButton = true
        title = "Home"
    }

    @IBAction func btnLogoutTapped(_ sender: Any) {
        UserDefaultsHelper.UserAccount.instance.userName = ""
        UserDefaultsHelper.UserAccount.instance.userPassword = ""
        
//        let vc: WelcomeAppVC = UIStoryboard.Main.welcomeVC() as! WelcomeAppVC
//        self.navigationController?.pushViewController(vc, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func btnMovieListTapped(_ sender: Any) {
        let vc: MovieListVC = UIStoryboard.Movie.movieListVC() as! MovieListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
