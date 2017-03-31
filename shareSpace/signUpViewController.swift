//
//  signUpViewController.swift
//  shareSpace
//
//  Created by Paul Choi on 3/31/17.
//  Copyright © 2017 Oray. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUp(_ sender: Any) {
        if self.passwordField.text != self.passwordField2.text{
            
            let alertController = UIAlertController(title: "Oops!", message: "Password does not match", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
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
   

}
