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

    var achor : RAchorModel? {
        didSet {
            self.roomNameLabel.text = achor?.nickname
            self.actorNameLabel.text = achor?.room_name
            guard let vertical_src = achor?.vertical_src else {
                return
            }
            guard let url = URL(string: vertical_src) else {
                return
            }
            self.backImage.kf.setImage(with: url)
            
            guard let number = achor?.online else {
                return
            }
            var onlineNUm : String = ""
            if number > 10000 {
                let n = number / 10000
                onlineNUm = "\(n)万人在线"
            }else{
                onlineNUm = "\(number)人在线"
            }
            self.onlineNum.setTitle(onlineNUm, for: .normal)
        }
    }
}
