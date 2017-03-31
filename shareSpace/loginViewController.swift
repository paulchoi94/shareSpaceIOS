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


class loginViewController: UIViewController, FBSDKLoginButtonDelegate{
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let fbLoginButton = FBSDKLoginButton(type: .system)
        view.addSubview(fbLoginButton)
        fbLoginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["email", "public_profile"]
        /*
        fbLoginButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)*/
        
        
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Login with Facebook", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor( .white, for: .normal)
        view.addSubview(customFBButton)
        
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        
    }

    func handleCustomFBLogin(){
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil{
                print ("log in failed")
                return
            }
            
            self.storeToFirebase()
        }
    }
    
    func storeToFirebase(){
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else
        { return }
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, err) in
            if err != nil{
                print ("went wrong with FB user")
                return
            }
            
            print ("successfully logged in with fb user", user!)
        })
        
        //getting the id name and email
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print ("failed to start graph request:", err!)
                return
            }
            
            print (result!)
            
        }

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print ("did log out of facebook")
    }
    
    //using facebook's login button
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        //getting the id name and email
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            
            if err != nil {
                print ("failed to start graph request:", err!)
                return
            }
            
            print (result!)
            
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        if self.usernameField.text == "" || self.passwordField.text == ""{
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            
            FIRAuth.auth()?.signIn(withEmail: self.usernameField.text!, password: self.passwordField.text!
                , completion: {
                    (user, error) in
                    
                    //send it to the next view
                    if error == nil{
                        /*
                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "mainViewController") as UIViewController
                        
                        self.present(vc, animated: true, completion: nil)
                        */
                        
                        let alertController = UIAlertController(title: "hahahha!", message: "yes it works", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                        //there was an error
                    else{
                        let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
            })
        }

    }

    @IBAction func signup(_ sender: Any) {
        
        if self.usernameField.text == "" || self.passwordField.text == ""{
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        //create an account
        else{
            
            FIRAuth.auth()?.createUser(withEmail: self.usernameField.text!, password: self.passwordField.text!, completion: {
                (user, error) in
                
                //send it to the next view
                if error == nil{
                    let alertController = UIAlertController(title: "Congrats!", message: "account was created", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    /*
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "mainViewController") as UIViewController
                    
                    self.present(vc, animated: true, completion: nil)
                    */
                    
                }
                //there was an error
                else{
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
            })
            
        }
    }
    
    //facebook login
    @IBAction func facebookLogin(_ sender: Any) {
    }
    

}
