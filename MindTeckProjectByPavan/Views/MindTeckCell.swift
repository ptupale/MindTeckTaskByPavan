//
//  AttendanceCell.swift
//  Employee Attendance
//
//  Created by Pavankumar Tupale on 28/09/21.
//

import UIKit

class MindTeckCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var userData: UserDataModel? {
        didSet {
            nameLabel.text = userData?.userName
            logoImageView.image = userData?.image
        }
    }
    
}
