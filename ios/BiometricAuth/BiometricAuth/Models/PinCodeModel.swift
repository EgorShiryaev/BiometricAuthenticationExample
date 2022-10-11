//
//  PinCodeModel.swift
//  biomeric_auth_example
//
//  Created by Shiryaev Egor on 07.10.2022.
//

import UIKit

class PinCodeModel: NSObject {
    
    private let repository = PinCodeRepository()

    private var pinCode = "";
    
    private var pinCodeIsChecking = false;

    func getLockingPinCodeIsSetted() -> Bool? {
        let lockingPinCode = repository.getSavedPinCode();
        return lockingPinCode != nil;
    }
    
    func addPinCodeChar(char:Character) -> Int{
        pinCode.append(char)
        let indexNewElement = getPinCodeLenght() - 1;
        return indexNewElement;
    }
    
    func removeLastPinCodeChar(){
        guard (pinCode.count > 0) else {return}
        pinCode.removeLast();
    }
    
    func checkPinCodeIsEquals() -> Bool{
        let isEquals = repository.getSavedPinCode() == pinCode
        pinCode.removeAll();
        return isEquals
    }
    
    func getPinCodeLenght()->Int{
        let lenght = pinCode.count;
        return lenght
    }
    
    func savePinCode(){
        repository.savePinCode(code: pinCode);
        pinCode.removeAll();
    }
}



