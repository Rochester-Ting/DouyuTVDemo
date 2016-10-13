//
//  RecommanBeautifulCell.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 13/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RecommanBeautifulCell: UICollectionViewCell {
    // MARK:- 主播名字
    @IBOutlet weak var actorNameLabel: UILabel!
    // MARK:- 主播定位
    @IBOutlet weak var location: UILabel!
    // MARK:- 背景图
    @IBOutlet weak var backImage: UIImageView!
    // MARK:- 在线人数
    @IBOutlet weak var onlineNum: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backImage.layer.cornerRadius = 3
        onlineNum.layer.cornerRadius = 3
        backImage.clipsToBounds = true
        onlineNum.clipsToBounds = true
    }

}
