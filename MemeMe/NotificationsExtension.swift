import Foundation

extension MemeEditorViewController {
    
    func subscribeForNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardPopped), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
    }
}
