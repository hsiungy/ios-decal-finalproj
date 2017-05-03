//
//  ViewController.swift
//  found_1
//
//  Created by applesys on 5/1/17.
//  Copyright © 2017 applesys. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore


class LoginViewController: UIViewController, LoginButtonDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.delegate = self
        if AccessToken.current != nil {
            // User is logged in, use 'accessToken' here.
            performSegue(withIdentifier: "loginToMain", sender: self)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Checks if user is already signed in and skips login
        if (FBSDKAccessToken.current() != nil) {
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        }
    }

    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Login Success!==================******")
        switch result {
        case .failed(let error):
            print("Facebook Authentication Error")
            print(error)
        case .cancelled:
            print("Facebook Authentication Cancelled")
            break
        case .success( _, _, _):
            print("====================")
            performSegue(withIdentifier: "loginToMain", sender: self)
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        //        LoginManager.getInstance().logout();
        LoginManager.init().logOut()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

