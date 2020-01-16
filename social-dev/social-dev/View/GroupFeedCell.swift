//
//  GroupFeedCell.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 16/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Functions
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.profileImg.image = UIImage(named: "DefaultProfileImage")
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
    
}
