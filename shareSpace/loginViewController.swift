//
//  loginViewController.swift
//  shareSpace
//
//  Created by Paul Choi on 3/12/17.
//  Copyright © 2017 Oray. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit


class loginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        //fix later to use constraints
        loginButton.frame = CGRect(x:16, y:50, width: view.frame.width -
            32, height: 50)
        
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
    
    
    //called when the user is logged in with facebook
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("did log out of facebook")
    }
 
    //called when fb button is pressed and hands back user info
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print (error)
            return
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil{
                print("Failed to start graph request:", err!)
            }
            
            //this result has id and name without the email, so use id as unique identifier
            print(result!)
            
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else{
                return
            }
            
            let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
            FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error
                ) in
                if error != nil{
                    print ("something wrong with FB user: ", error ?? "")
                    return
                }
                
                print("Successfully logged in with out user:", user ?? "")
                
                
            })
        }
    }
    
    //loads authViewcontroller
    @IBAction func login(_ sender: Any) {
        
        //sends to the login view controller
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "authViewController") as UIViewController
        
        self.present(vc, animated: true, completion: nil)
    }

    //loads signupViewController
    @IBAction func signup(_ sender: Any) {
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "signUpViewController") as UIViewController
                    
        self.present(vc, animated: true, completion: nil)
    }
    

}
