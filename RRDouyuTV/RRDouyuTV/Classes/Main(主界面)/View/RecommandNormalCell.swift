//
//  RecommandNormalCell.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 13/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RecommandNormalCell: UICollectionViewCell {
    // MARK:- 背景图
    @IBOutlet weak var backImage: UIImageView!
    // MARK:- 主播名字
    @IBOutlet weak var actorNameLabel: UILabel!
    // MARK:- 房间名字
    @IBOutlet weak var roomNameLabel: UILabel!
    // MARK:- 在线人数
    @IBOutlet weak var onlineNum: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backImage.layer.cornerRadius = 3
        backImage.clipsToBounds = true
    }

}
