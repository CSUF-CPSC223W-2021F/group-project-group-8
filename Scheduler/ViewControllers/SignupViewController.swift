//
//  SignupViewController.swift
//  Scheduler
//
//  Created by Badillo, Nancy on 11/18/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
    }

    func validateFields() -> String? {
        // Check that all fields are filled in
        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ==  "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enoough
            return "Please mke sure your password contains at least 8 characters, a special character and a number."
        }
        
        return nil
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        // To change root view controller, you need to set a Storyboard ID and create a new instance and swap out the root
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signUpTapped(_ sender: Any){
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
        // There's something wrong with the fields, show error message
            showError(error!)
        } else {
            
            // Create "cleaned" version of user data
            let username = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // check for Errors
                if err != nil {
                        // There was an error
                    self.showError("Error creating user")
                } else {
                    // User was created, store information
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["username": username, "uid": result!.user.uid ]) { (error) in
                        if error != nil {
                            self.showError("Username could not be saved to database.")
                        }
                    }
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
            
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
