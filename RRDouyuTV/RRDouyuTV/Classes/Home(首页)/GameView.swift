//
//  GameView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class GameView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.red
    }
    class func gameView()->GameView{
        return Bundle.main.loadNibNamed("GameView", owner: nil, options: nil)?.first as! GameView
    }
}
