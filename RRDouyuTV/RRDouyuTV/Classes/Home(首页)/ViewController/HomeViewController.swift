//
//  HomeViewController.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 10/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let TitleViewH : CGFloat = 40;
class HomeViewController: UIViewController {
    // MARK:- 懒加载PageTitleView
    private lazy var pageTitleView : PageTitleView = {
        let TitleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationH, width: kScreenW, height: TitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: TitleFrame, titles: titles)
        
        return titleView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        view.addSubview(pageTitleView)
        automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// MARK:- 设置UI
extension HomeViewController{
    public func setUpUI(){
        setNavigationBar()
        
    }
    private func setNavigationBar() {
        //设置左边的logo
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named:"logo"), for: .normal)
        leftBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
//        设置右边的按钮
        let size = CGSize(width: 40, height: 40)
        let hisItem = UIBarButtonItem(name: "image_my_history", highName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(name: "btn_search", highName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(name: "Image_scan", highName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [qrcodeItem,searchItem,hisItem]
    }
}
