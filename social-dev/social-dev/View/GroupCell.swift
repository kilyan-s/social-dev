//
//  GroupCell.swift
//  social-dev
//
//  Created by Kilyan SOCKALINGUM on 16/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescrLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Func
    func configureCell(withTitle title: String, andDescription descr: String, numberOfMembers count:Int) {
        self.groupTitleLbl.text = title
        self.groupDescrLbl.text = descr
        self.memberCountLbl.text = "\(count) members."
    }
}
