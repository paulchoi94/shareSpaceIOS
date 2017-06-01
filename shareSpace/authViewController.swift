//
//  authViewController.swift
//  shareSpace
//
//  Created by Paul Choi on 5/31/17.
//  Copyright © 2017 Oray. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class authViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
    
    }
    
    //start firebase auth process
    @IBAction func logInWithFireBase(_ sender: Any) {
        
        if self.emailField.text == "" || self.passwordField.text == "" {
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            
            FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!
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

}
