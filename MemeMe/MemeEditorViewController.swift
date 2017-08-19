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
    
    var paragraphStyle : NSMutableParagraphStyle!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        paragraphStyle = NSMutableParagraphStyle()
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
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            originalImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //After keyboard pops up
    func keyboardPopped(){
        print("popped")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
