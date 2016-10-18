//
//  BaseViewController.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 18/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var contentView : UIView?
    fileprivate lazy var AnimImage : UIImageView = {
        let AnimImage = UIImageView(image:UIImage(named: "img_loading_1"))
        AnimImage.center = self.view.center
        AnimImage.autoresizingMask = [.flexibleBottomMargin,.flexibleTopMargin]
        AnimImage.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        AnimImage.animationDuration = 0.5
        AnimImage.animationRepeatCount = LONG_MAX
        return AnimImage
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
}
extension BaseViewController{
    func setUpUI(){
        contentView?.isHidden = true
        view.backgroundColor = UIColor.white
        view.addSubview(AnimImage)
        AnimImage.startAnimating()
        
    }
    func stopAnimation(){
        AnimImage.stopAnimating()
        contentView?.isHidden = false
        AnimImage.isHidden = true
    }
}
