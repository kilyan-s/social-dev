//
//  UserCell.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 15/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkmarkImg: UIImageView!
    
    //variables
    //var showing: Bool = false
    
    func configureCell(withProfileImg image: UIImage, andEmail email: String, andIsSelected isSelected: Bool) {
        self.profileImg.image = image
        self.emailLbl.text = email
        
        if isSelected {
            self.checkmarkImg.isHidden = false
        } else {
            self.checkmarkImg.isHidden = true
        }
        
        
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        if selected {
//            if !self.showing {
//                self.checkmarkImg.isHidden = false
//                self.showing = true
//            } else {
//                self.checkmarkImg.isHidden = true
//                self.showing = false
//            }
//        }
//    }
    
    func updateSelectedStatus(isSelected: Bool) {
        //print("updateSelectedStatus \(isSelected) ishidden \(self.checkmarkImg.isHidden)")
        if isSelected {
            self.checkmarkImg.isHidden = false
        } else {
            self.checkmarkImg.isHidden = true
        }
    }
    
    

    
}
