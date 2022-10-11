//
//  BiometricModel.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 11.10.2022.
//

import UIKit
import LocalAuthentication

class BiometricAuthModel: NSObject {
    let context = LAContext()
    func getBiometricType()->LABiometryType{
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        return context.biometryType
    }
    
    private func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
      }
    
    func runBiometricAuth(onSuccess: @escaping () -> Void, onFail: @escaping (_ error : Error?) -> Void ){
        context.localizedCancelTitle = "Ввести пин-код"
        let loginReason = "Авторизуйтесь с помощью Touch ID"
        // First check if we have the needed hardware support.
        guard canEvaluatePolicy() else {return}
        return context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: loginReason
        ) { (success, evaluateError) in
            DispatchQueue.main.async{
            if (success){
                onSuccess()
            } else {
                onFail(evaluateError)
            }
            }
          }
    }
}
