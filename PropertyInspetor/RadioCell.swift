//
//  RadioCell.swift
//  PropertyInspetor
//
//  Created by admin on 16/12/26.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import SDWebImage
class RadioCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImg: UIImageView!
    var data:RadioModel!{
        willSet{
            self.data = newValue
        }
        didSet{
            self.coverImg.sd_setImageWithURL(NSURL.init(string: self.data.coverimg), placeholderImage: UIImage(named: "WechatIMG1.jpeg"))
            self.titleLabel.text = self.data.title
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
