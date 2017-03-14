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

class loginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
