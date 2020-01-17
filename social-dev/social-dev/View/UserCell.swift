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
    
    func configureCell(withProfileImg image: UIImage, andEmail email: String, andIsSelected isSelected: Bool) {
        self.profileImg.image = image
        self.emailLbl.text = email
        
        if isSelected {
            self.checkmarkImg.isHidden = false
        } else {
            self.checkmarkImg.isHidden = true
        }
    }
    
    func updateSelectedStatus(isSelected: Bool) {
        if isSelected {
            self.checkmarkImg.isHidden = false
        } else {
            self.checkmarkImg.isHidden = true
        }
    }
}
