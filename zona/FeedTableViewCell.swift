//
//  FeedTableViewCell.swift
//  zona
//
//  Created by MacDouble on 2/20/18.
//  Copyright © 2018 MacDouble. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class FeedTableViewCell: UITableViewCell {

    
    let uniWidth = UIScreen.main.bounds.width
    let uniHeight = UIScreen.main.bounds.height
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let profileView = UIImageView.init(image: UIImage.init(named: "profileImage"))
        profileView.frame = CGRect(x: 12, y: 15, width: 30, height: 30)
        let nameLabel = UILabel.init(frame: CGRect(x: 47, y: 15, width: self.bounds.width-47, height: 15))
        nameLabel.text = "加州大学圣克鲁兹分校"
        nameLabel.font = UIFont(name: "SourceHanSansSC-Regular", size: 12)
        
        let cateLabel = UILabel.init(frame: CGRect(x: 47, y: 30, width: uniWidth-47, height: 15))
        cateLabel.text = "闲聊"
        cateLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        cateLabel.font = UIFont(name: "SourceHanSansSC-Light", size: 12)
        
        let titleLabel = UILabel.init(frame: CGRect(x: 12, y: 53, width: self.bounds.width-24, height: 15))
        titleLabel.text = "在美国Costco买的鱼竟然有活虫！已经有人中招！"
        titleLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.font = UIFont(name: "SourceHanSansSC-Bold", size: 15)
        
        let descLabel = UILabel.init(frame: CGRect(x: 12, y: 74, width: uniWidth-24, height: 15))
        descLabel.text = "前几天，穿出了一条Costco的负面新闻：一个女士在costco买的鱼中看到了一条活的虫子"
        descLabel.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        descLabel.font = UIFont(name: "SourceHanSansSC-Light", size: 13)
        
        self.addSubview(profileView)
        self.addSubview(cateLabel)
        self.addSubview(nameLabel)
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
