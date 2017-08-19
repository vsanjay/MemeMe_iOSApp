//
//  ViewController.swift
//  MemeMe
//
//  Created by VERDU SANJAY on 19/08/17.
//  Copyright © 2017 VERDU SANJAY. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var navbar: UIToolbar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var activityViewController : UIActivityViewController!
    let textFieldDelegate = TextFieldsDelegate()
    
    // Hide status so that it wont cover our toolbar at top
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        subscribeForNotifications()
        
        //Setting share button to disabled mode
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        //Custom Text Attributes
        let memeTextAttributes : [String:Any] = [
            
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 20),
            NSStrokeWidthAttributeName : -3.0,
            NSParagraphStyleAttributeName : paragraphStyle
        ]
        
        // Setting TextFields Attributes
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        //Checking if camera option is available for the device or not
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    //Camera Button is Tapped
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        pickImage(source: .camera)
    }
    
    //Album button is tapped
    @IBAction func albumButtonTapped(_ sender: Any) {
        
        pickImage(source: .photoLibrary)
    }
    
    //Pick image from a selected source
    func pickImage(source : UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Set image to our imageview after finishing pinking image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        shareButton.isEnabled = true
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            originalImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    //After keyboard pops up
    func keyboardPoppedUp(notification : Notification){
        if bottomTextField.isFirstResponder {
            self.view.center.y -= getKeyboardHeight(notification: notification)
        }
    }
    
    //After keyboard pops up
    func keyboardPoppedDown(notification : Notification){
        if bottomTextField.isFirstResponder {
            self.view.center.y += getKeyboardHeight(notification: notification)
        }
    }
    
    //Get Keyboard Height
    func getKeyboardHeight(notification : Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardHeight = userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardHeight.cgRectValue.height
    }
    
    //Share your image
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let image = generateImage()
        activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true) {
            self.saveMeme()
        }
    }
    
    //Cancel Button Tapped
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        topTextField.text = "TOP TEXT HERE"
        bottomTextField.text = "BOTTOM TEXT HERE"
        originalImage.image = UIImage()
        shareButton.isEnabled = false
    }
    
    //Generate memed Image
    func generateImage() -> UIImage {
        
        //Hide navbar and toolbar
        hideOrUnhideToolbarNavbar(bool: true)
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //unhide navbar and toolbar
        hideOrUnhideToolbarNavbar(bool: false)
        return memedImage!
    }
    
    //hide or unhide navbar and toolbar
    func hideOrUnhideToolbarNavbar(bool : Bool){
        navbar.isHidden = bool
        toolbar.isHidden = bool
    }
    
    //Saving meme
    func saveMeme(){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: originalImage.image!, memedImage: generateImage())
    }
}
