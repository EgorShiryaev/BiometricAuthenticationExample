//
//  SavedPinCodeModel.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 10.10.2022.
//

import UIKit

class PinCodeRepository: NSObject {
    
    private var pinCode: String?;
    
    func getSavedPinCode() -> String?{
        if (pinCode != nil){
            return pinCode
        }
        pinCode = savedPinCode;
        return savedPinCode;
    }
    
    func savePinCode(code: String){
        pinCode = code;
        savedPinCode = code;
    }
}

var savedPinCode:String? = nil;
