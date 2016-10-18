//
//  GameViewCell.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class GameViewCell: UICollectionViewCell {
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    var gameModel : RGameModel?{
        didSet {
            
            let url = URL(string: (gameModel?.icon_url)!)
            
            gameImage.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
            
            titleNameLabel.text = gameModel?.tag_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        gameImage.layer.cornerRadius = 22.5
        gameImage.clipsToBounds = true
    }

}
