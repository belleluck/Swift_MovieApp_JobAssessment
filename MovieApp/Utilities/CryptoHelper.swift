//
//  CryptoHelper.swift
//  MovieApp
//
//  Created by Belleluck Low Chia Hao on 02/09/2023.
//

import Foundation
import CryptoSwift

class CryptoHelper {

    // 10 char secret key
    private static let key = "b31131uck!";

    // Custom function to replace unocide symbol "+" to encoded characters "%2b"
    public func encryptPassword(plainText: String) -> String {
        if let password = CryptoHelper.encrypt(input: plainText) {
            let cipherText: String = password.replacingOccurrences(of: "+", with: "%2b")

            return cipherText
        } else {
            return ""
        }
    }
    
    public func decryptPassword(plainText: String) -> String {
        
        let cipherText = plainText.replacingOccurrences(of: "%2b", with: "+")
        if let password = CryptoHelper.decrypt(input: cipherText) {
            return password
        } else {
            return ""
        }
    }

    public static func encrypt(input: String) -> String? {
        do {
            let encrypted: Array<UInt8> = try AES(key: key, iv: key, padding: .pkcs5).encrypt(Array(input.utf8))

            return encrypted.toBase64()
        } catch {
            print("Crypto Helper > encrypt error: \(error)")
        }

        return nil
    }

    public static func decrypt(input: String) -> String? {
        do {
            let d = Data(base64Encoded: input)
            let decrypted = try AES(key: key, iv: key, padding: .pkcs5).decrypt(d!.bytes)

            return String(data: Data(decrypted), encoding: .utf8)
        } catch {
            print("Crypto Helper > decrypt error: \(error)")
        }

        return nil
    }
}
