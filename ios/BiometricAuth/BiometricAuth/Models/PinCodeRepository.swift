//
//  SavedPinCodeModel.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 10.10.2022.
//

import UIKit

class SavedPinCodeModel: NSObject {
    
    private var pinCode: String?;
    
    func getSavedPinCode() -> String{
        if (pin)
        guard(pinCode == nil) else {return pinCode}
        pinCode = savedPinCode;
        return savedPinCode;
    }
}

let savedPinCode = "1234";
