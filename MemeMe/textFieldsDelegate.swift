import Foundation
import UIKit

class TextFieldsDelegate : NSObject,UITextFieldDelegate {
    
    //Hide Keyboard when tapped on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Remove all the text in the text field when user taps on it.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }

}
