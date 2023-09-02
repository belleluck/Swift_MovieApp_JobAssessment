//
//  UserDefaultHelper.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 31/08/2023.
//

import Foundation

let defaults: UserDefaults = UserDefaults.standard

class UserDefaultsHelper {
    
    class DatabaseVersion {
        static let instance = DatabaseVersion()
        var movieDBVersion: Int {
            get {
                return defaults.integer(forKey: "movie_database_version")
            }
            set {
                defaults.set(newValue, forKey: "movie_database_version")
            }
        }
    }
    
    class UserAccount {
        static let instance = UserAccount()
        var userName: String {
            get {
                if let nameString = defaults.string(forKey: "userName") {
                    return nameString
                }
                else {
                    return ""
                }
            }
            set {
                defaults.set(newValue, forKey: "userName")
            }
        }
        var userPassword: String {
            get {
                if let pwdString = defaults.string(forKey: "userPassword") {
                    return pwdString
                }
                else {
                    return ""
                }
            }
            set {
                defaults.set(newValue, forKey: "userPassword")
            }
        }
    }
}
