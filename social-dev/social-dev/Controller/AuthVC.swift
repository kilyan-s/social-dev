//
//  AuthVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 13/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {
    
    //Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Actions
    @IBAction func signinByEmailWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func signinByGoogleWasPressed(_ sender: Any) {
    }
    
    @IBAction func signinByFbWasPressed(_ sender: Any) {
    }
}
