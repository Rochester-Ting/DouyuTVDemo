//
//  MainViewController.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 9/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let num = UIDevice.current.systemVersion
//        let version = (num as NSString).floatValue
//        if version >= 9.0 {
//            return
//        }
        addChilidVC(storyBoad: "HomeViewController")
        addChilidVC(storyBoad: "LiveViewController")
        addChilidVC(storyBoad: "FolloewViewController")
        addChilidVC(storyBoad: "MeViewController")
    }
    private func addChilidVC(storyBoad :String){
        let vc = UIStoryboard(name: storyBoad, bundle: nil).instantiateInitialViewController()!
        vc.view.backgroundColor = UIColor.white
        addChildViewController(vc)
    }
}
