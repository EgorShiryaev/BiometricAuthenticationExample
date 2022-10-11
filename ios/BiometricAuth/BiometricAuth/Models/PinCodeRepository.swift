//
//  SavedPinCodeModel.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 10.10.2022.
//

import UIKit
import SwiftKeychainWrapper

let keychainPinCodeKey = "pinCode"

class PinCodeRepository: NSObject {
    
    func getSavedPinCode() -> String?{
        return  KeychainWrapper.standard.string(forKey: keychainPinCodeKey);
    }
    
    func savePinCode(code: String){
        KeychainWrapper.standard.set(code, forKey: keychainPinCodeKey)
    }
}

