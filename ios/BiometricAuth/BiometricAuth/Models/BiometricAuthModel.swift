//
//  BiometricModel.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 11.10.2022.
//

import UIKit
import LocalAuthentication

enum StandartBiometricError:String, @unchecked Sendable{
    
    case Canceled = "Authentication canceled"
    
}

class BiometricAuthModel: NSObject {
    let context = LAContext()
    
    func getBiometricType()->LABiometryType{
        
        let result = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }
    
    private func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
      }
    
    func runBiometricAuth(onSuccess: @escaping () -> Void, onFail: @escaping (_ description : String, _ canTryAgain: Bool) -> Void ){
        guard canEvaluatePolicy() else {return}
        
        context.localizedCancelTitle = "Отмена"
        // Текст используется только при запросе отпечатка Touch ID
        let loginReason = "Чтобы авторизоваться, требуется Touch ID."
        return context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: loginReason
        
        ) { (success, evaluateError) in
            DispatchQueue.main.async{
                guard(!success) else {onSuccess(); return;}
                
                print(evaluateError?.localizedDescription)
                self.handleDefaultError(errorCode: evaluateError!._code, onFailFunc: onFail)
            }
          }
    }
    
    private func handleDefaultError(errorCode: Int, onFailFunc:  (_ description : String, _ canTryAgain: Bool) -> Void ){
        let failureDescription = generateFailureDescription(errorCode: errorCode)
        
        switch errorCode{
            case LAError.Code.userCancel.rawValue:
                return;
        case LAError.Code.appCancel.rawValue, LAError.Code.systemCancel.rawValue,  LAError.Code.authenticationFailed.rawValue,LAError.Code.invalidContext.rawValue, LAError.Code.userFallback.rawValue:
                return onFailFunc(failureDescription,true)
            
        case LAError.Code.biometryLockout.rawValue, LAError.Code.biometryNotAvailable.rawValue, LAError.Code.biometryNotEnrolled.rawValue,  LAError.Code.notInteractive.rawValue, LAError.Code.passcodeNotSet.rawValue:
                return onFailFunc(failureDescription,false)
            
            default:
                return onFailFunc(failureDescription,true)
        }
    
    }
    
    private func generateFailureDescription(errorCode:Int)->String{
        switch errorCode{
         
        case LAError.Code.appCancel.rawValue,
            LAError.Code.systemCancel.rawValue,  LAError.Code.authenticationFailed.rawValue,LAError.Code.invalidContext.rawValue, LAError.Code.userFallback.rawValue:
                return "Во время авторизации произошла ошибка."
            
        case LAError.Code.biometryLockout.rawValue:
                return "Биометрия заблокирована, так как было слишком много неудачных попыток."
        case  LAError.Code.biometryNotAvailable.rawValue:
            return "Биометрия на устройстве недоступна."
        case LAError.Code.biometryNotEnrolled.rawValue:
            return "Нет зарегистрированных биометрических идентификаторов. Зарегистрируйте идентификатор и повторите попытку."
        case LAError.Code.notInteractive.rawValue:
            return "Отображение требуемого пользовательского интерфейса аутентификации запрещено. Повторите попытку позже."
        case LAError.Code.passcodeNotSet.rawValue:
            return "Установите пароль на устройство и повторите попытку."
        default:
            return "Во время авторизации произошла ошибка."
     
            
        }
    }
    
    
}
