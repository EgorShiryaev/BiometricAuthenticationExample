//
//  PinCodeModel.swift
//  biomeric_auth_example
//
//  Created by Shiryaev Egor on 07.10.2022.
//

import UIKit

class PinCodeModel: NSObject {
    
    private var pinCode: String?;
    private var currentPinCode = "";
    
    var pinCodeIsChecking = false;
    var pinCodeIsExist = false;
    
    
    
    private func getSavedPinCode()->String?{
        //TODO
        return setupedPinCode;
    }
    
    func pinCodeIsExists()->Bool {
        let savedPinCode = getSavedPinCode()
        
        pinCodeIsExist = savedPinCode == nil
        
        return pinCodeIsExist;
    }
    
    func addPinCodeChar(char:Character){
        currentPinCode.append(char)
    }
    
    func removeLastPinCodeChar(){
        guard (currentPinCode.count > 0) else {return}
        currentPinCode.removeLast();
    }
    
    func pinCodeIsEquals() -> Bool{
        guard (pinCode != nil) else {return false}
        return pinCode == currentPinCode
    }
    
    func savePinCode(){
        setupedPinCode = currentPinCode;
    }
}


var setupedPinCode = "1234";
