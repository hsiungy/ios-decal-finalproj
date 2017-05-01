//
//  LoginViewController.swift
//  QRCodeReader
//
//  Created by YHsiung on 4/30/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import Firebase
import SinchVerification

class PhoneNumberViewController: UIViewController {
    
    var verification:Verification!
    var applicationKey:
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var status: UILabel!

    @IBOutlet weak var SMSButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Checks if user is already signed in and skips login
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func sendSMS(_ sender: Any) {
    }
//
//    /*
//     TODO:
//     
//     Implement login functionality using the Firebase Auth function for signing in.
//     You should check the result of the function call to see if it completes without error.
//     If an error occurs, display a message using a UIAlertController (e.g. "Sign in failed, try again")
//     Otherwise, perform a segue to the rest of the app using the identifier "loginToMain"
//     
//     */
//    @IBAction func didAttemptLogin(_ sender: UIButton) {
//        guard let phoneNumberText = phoneNumberField.text else { return }
//        guard let passwordText = passwordField.text else { return }
//        
//        // YOUR CODE HERE
//        FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText, completion: { (user, error) in
//            if let error = error {
//                // Implement Alert:
//                let alert = UIAlertController(title: "Sign-in Failed", message: "ry again?", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true)
//            } else {
//                self.performSegue(withIdentifier: "loginToMain", sender: self)
//            }
//        })
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
}

