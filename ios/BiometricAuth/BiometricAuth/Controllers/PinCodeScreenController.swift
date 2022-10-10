//
//  ViewController.swift
//  BiometricAuth
//
//  Created by Shiryaev Egor on 07.10.2022.
//

import UIKit

class PinCodeScreenController: UIViewController {
    
    let model = PinCodeModel();
    
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
    }
    
    private func setHelperText(){
        if (model.getLockingPinCodeIsSetted() == true){
            HelperText.text = "Введите пин-код, чтобы разблокировать"
        } else  {
            HelperText.text = "Введите пин-код, чтобы его установить"
        }
    }


    @IBAction func onPressNumberButton(_ sender: UIButton) {
        let char = sender.titleLabel?.text?.first;
        let index = model.addPinCodeChar(char:char! )
        fillCurrentImage(index: index)
        showDeleteButton()
        checkPinCodeIsFullIntroduced()
    }
    
    private func checkPinCodeIsFullIntroduced(){
        guard (model.getPinCodeLenght() == 4) else {return }
        
        setButtonEnabled(value:false)
        
        if (model.getLockingPinCodeIsSetted() == true){
            tryAuthorize()
        } else {
            setPinCodeToLock()
        }
        
        hideDeleteButton();
        clearAllPinCodeImages();
        setButtonEnabled(value:true)
    }
    
    private func tryAuthorize(){
        let success = model.checkPinCodeIsEquals()
        if (success){
            navigateToHomeScreen()
        } else {
            showAlertMessage()
        }
    }
    
    private func navigateToHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreen")
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    private func showAlertMessage(){
        let alertController = UIAlertController(title: "Не правильный пин-код", message: "Попрбуйте еще раз", preferredStyle: .alert);
        let action = UIAlertAction(title: "Ок", style: .default);
        alertController.addAction(action)
        
        self.present(alertController, animated: true);
    }
    
    private func setPinCodeToLock(){
        model.savePinCode()
        setHelperText();
    }
    
    private func setButtonEnabled(value:Bool){
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
        model.removeLastPinCodeChar()
        let pincodeLenght = model.getPinCodeLenght();
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
}

