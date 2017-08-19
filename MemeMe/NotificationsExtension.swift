import Foundation

extension MemeEditorViewController {
    
    func subscribeForNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardPoppedUp), name: Notification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardPoppedDown), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
}
