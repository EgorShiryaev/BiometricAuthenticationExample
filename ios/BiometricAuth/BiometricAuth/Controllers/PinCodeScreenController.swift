//
//  ViewController.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 07.10.2022.
//

import UIKit
import LocalAuthentication

class PinCodeScreenController: UIViewController {
    
    let pinCodeModel = PinCodeModel();
    let biometricAuthModel = BiometricAuthModel()
    
    @IBOutlet weak var FirstCharacterImage: UIImageView!
    @IBOutlet weak var SecondCharacterImage: UIImageView!
    @IBOutlet weak var ThirdCharacterImage: UIImageView!
    @IBOutlet weak var FourthCharacterImage: UIImageView!
    
    @IBOutlet weak var ButtonOne: UIButton!
    @IBOutlet weak var ButtonTwo: UIButton!
    @IBOutlet weak var ButtonThree: UIButton!
    @IBOutlet weak var ButtonFour: UIButton!
    @IBOutlet weak var ButtonFive: UIButton!
    @IBOutlet weak var ButtonSix: UIButton!
    @IBOutlet weak var ButtonSeven: UIButton!
    @IBOutlet weak var ButtonEight: UIButton!
    @IBOutlet weak var ButtonNine: UIButton!
    @IBOutlet weak var ButtonZero: UIButton!
    
    @IBOutlet weak var BiometricAuthButton: UIButton!
    @IBOutlet weak var DeleteLastButton: UIButton!
    
    @IBOutlet weak var HelperText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHelperText()
        hideDeleteButton();
        setBiometricIcon();
        if (pinCodeModel.getLockingPinCodeIsSetted() == true){
            tryBiometricAuth()
        }
      
    }
    
    private func setHelperText(){
        if (pinCodeModel.getLockingPinCodeIsSetted() == true){
            HelperText.text = "Введите пин-код, чтобы разблокировать"
        } else  {
            HelperText.text = "Введите пин-код, чтобы его установить"
        }
    }
    
    private func setBiometricIcon(){
        let biometryType = biometricAuthModel.getBiometricType()
      
        if (biometryType == LABiometryType.faceID){
            let faceIdIconImage = "FaceIdIcon";
            let image = UIImage(named:faceIdIconImage)
            BiometricAuthButton.setImage(image, for: UIControl.State.normal)
        } else if (biometryType == LABiometryType.touchID){
            let touchIdIconImage = "TouchIdIcon";
            let image = UIImage(named:touchIdIconImage)
            BiometricAuthButton.setImage(image, for: UIControl.State.normal)
        } else if (biometryType == LABiometryType.none){
            BiometricAuthButton.isHidden = true
        }
    }

    @IBAction func onPressNumberButton(_ sender: UIButton) {
        let char = sender.titleLabel?.text?.first;
        let index = pinCodeModel.addPinCodeChar(char:char! )
        fillCurrentImage(index: index)
        showDeleteButton()
        checkPinCodeIsFullIntroduced()
    }
    
    private func checkPinCodeIsFullIntroduced(){
        guard (pinCodeModel.getPinCodeLenght() == 4) else {return }
        
        setButtonEnabled(false)
        
        if (pinCodeModel.getLockingPinCodeIsSetted() == true){
            tryAuthorize()
        } else {
            setPinCodeToLock()
        }
                
        hideDeleteButton();
        clearAllPinCodeImages();

        setButtonEnabled(true)
    }
    
    private func tryAuthorize(){
        let success = pinCodeModel.checkPinCodeIsEquals()
        if (success){
            navigateToHomeScreen()
        } else {
            showAlertPinCodeIsWrong()
        }
        
    }
    
  
    
    private func navigateToHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreen")
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    private func showAlertPinCodeIsWrong(){
        let alertController = UIAlertController(title: "Не правильный пин-код", message: "Попробуйте еще раз", preferredStyle: .alert);
        let action = UIAlertAction(title: "Ок", style: .default);
        alertController.addAction(action)
        
        self.present(alertController, animated: true);
    }
    
    private func setPinCodeToLock(){
        pinCodeModel.savePinCode()
        setHelperText();
        showSuccessSetPinCodeToLock()
    }
    
    private func showSuccessSetPinCodeToLock(){
        let alertController = UIAlertController(title: "Пин-код установлен", message: "Повторно введите пин-код для разблокировки", preferredStyle: .alert);
        let action = UIAlertAction(title: "Ок", style: .default);
        alertController.addAction(action)
        
        self.present(alertController, animated: true);
    }
    
    private func setButtonEnabled(_ value:Bool){
        let buttons = [
         ButtonOne,
         ButtonTwo,
         ButtonThree,
         ButtonFour,
         ButtonFive,
         ButtonSix,
         ButtonSeven,
         ButtonEight,
         ButtonNine,
         ButtonZero,
         BiometricAuthButton,
         DeleteLastButton
        ]
        
        for button in buttons{
            button?.isEnabled = value;
        }
        
        
    }
    
    private func clearAllPinCodeImages(){
        changePinCodePointImage(filling:false, all: true, index: nil)
    }
    
    private func fillAllPinCodeImages(){
        changePinCodePointImage(filling:true, all: true, index: nil)
    }
    
    private func fillCurrentImage(index:Int){
        changePinCodePointImage(filling:true, all: false, index: index)
    }
    
    private func clearCurrentImage(index:Int){
        changePinCodePointImage(filling:false, all: false, index: index)
    }
    
    private func changePinCodePointImage(filling :Bool, all : Bool?, index:Int?){
        let pinCodePointsImages = [FirstCharacterImage, SecondCharacterImage, ThirdCharacterImage,FourthCharacterImage ]
       
        if (all == true){
            for uiImageView in pinCodePointsImages {
                changePointImage(uiImageView: uiImageView!, filling: filling)
            }
        } else if (index != nil){
            changePointImage(uiImageView: pinCodePointsImages[index!]!, filling: filling)
        }
    }
    
    private func changePointImage(uiImageView:UIImageView, filling:Bool){
        let filledImage = "FilledPinCodeCharacter";
        let emptyImage = "EmptyPinCodeCharacter";
        uiImageView.image = UIImage(named:filling ? filledImage : emptyImage);
    }
    
    @IBAction func onPressDeleteButton(_ sender: UIButton) {
        pinCodeModel.removeLastPinCodeChar()
        let pincodeLenght = pinCodeModel.getPinCodeLenght();
        clearCurrentImage(index: pincodeLenght)
        if (pincodeLenght == 0){
            hideDeleteButton()
        }
    }
    
    private func hideDeleteButton(){
        guard (!DeleteLastButton.isHidden) else {return}
        DeleteLastButton.isHidden = true
    }
    
    private func showDeleteButton(){
        guard (DeleteLastButton.isHidden) else {return}
        DeleteLastButton.isHidden = false
    }
    
    @IBAction func onPressBiometricAuthButton(_ sender: Any) {
        tryBiometricAuth()
    }
    
    private func tryBiometricAuth(){
        biometricAuthModel.runBiometricAuth(onSuccess: onSuccessBiometricAuth, onFail: showBiometricError)
    }
    
    private func onSuccessBiometricAuth(){
        navigateToHomeScreen()
    }
    
    private func showBiometricError(_ error: Error?){
        let alertController = UIAlertController(title: "Произошла ошибка", message: error?.localizedDescription, preferredStyle: .alert);
        let action = UIAlertAction(title: "Ок", style: .default);
        alertController.addAction(action)
        
        self.present(alertController, animated: true);
    }
}

