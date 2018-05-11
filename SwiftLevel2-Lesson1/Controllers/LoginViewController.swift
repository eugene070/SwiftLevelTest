//
//  LoginViewController.swift
//  SwiftLevel2-Lesson1
//
//  Created by Eugene Losev on 08.05.2018.
//  Copyright © 2018 Eugene Losev. All rights reserved.
//

import UIKit

struct Credentials {
    static let validEmail = "admin"
    static let validPassword = "1"
}

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action:
            #selector(self.hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return checkEnteredValues()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления, одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name:
            NSNotification.Name.UIKeyboardWillShow, object: nil)
        // Второе когда она пропадает
        NotificationCenter.default.addObserver(self, selector:
            #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide,
                                                                 object: nil)
    }
    
    func checkEnteredValues() -> Bool {
        guard let userEmail = emailTextField.text, let userPassword = passwordTextField.text else {
            return false
        }
        guard userEmail == Credentials.validEmail, userPassword == Credentials.validPassword else {
            print("Credentials error")
            return false
        }
        return true
    }
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    // когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        // получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        print(contentInsets)
        // добавляем отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        print(scrollView as Any)
    }
    //когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
}

