//
//  RecommandHeadView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 13/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class RecommandHeadView: UICollectionReusableView {
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var tag_name: UILabel!
    
    var achorGame : RGameModel? {
        didSet{
            guard let achorGame = achorGame else {
                return
            }
            self.image.image = UIImage(named: achorGame.icon_name)
            self.tag_name.text = achorGame.tag_name
        }
    }
    class func headView()->RecommandHeadView{
        return Bundle.main.loadNibNamed("RecommandHeadView", owner: nil, options: nil)?.first as! RecommandHeadView
    }
    
}
