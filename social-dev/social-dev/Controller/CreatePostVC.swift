//
//  createPostVC.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 15/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
        // Do any additional setup after loading the view.
    }
    
    //Actions
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here ..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text!, forUid: Auth.auth().currentUser!.uid, withGroupKey: nil) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("There was an error")
                }
                
                self.sendBtn.isEnabled = true
            }
        }
        
    }
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
