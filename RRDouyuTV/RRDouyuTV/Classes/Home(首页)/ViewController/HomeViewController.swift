//
//  HomeViewController.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 10/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    // MARK:- 懒加载PageTitleView
    open lazy var pageTitleView : PageTitleView = {[weak self] in
        let TitleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: TitleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    // MARK:- 懒加载PageContentView
    open lazy var pageContentView : PageContentView = {[weak self] in
        let contentH = kScreenH - kStatusBarH - kNavigationH - kTitleViewH
        let pageContentViewFrame = CGRect(x: 0, y: kNavigationH + kStatusBarH + kTitleViewH, width: kScreenW, height: contentH)
        // 创建一个可变数组保存childVC
        var childVC : [UIViewController] = [UIViewController]()
        let recommandVC  = RecommandVC()
        childVC.append(recommandVC)
        childVC.append(GameVC())
        childVC.append(AmuseVC())
        childVC.append(FunnyVC())
//        for _ in 0..<1 {
//            let vc = UIViewController()
//            // MARK:- 设置vc的背景颜色
//            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1)
////            vc.view.backgroundColor = UIColor.red
//            childVC.append(vc)
//        }
        let pageContentView = PageContentView(frame: pageContentViewFrame, childVC: childVC, parentVC:self!)
        pageContentView.delegate = self
        
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
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
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    fileprivate func setNavigationBar() {
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
// MARK:- 遵守PagetitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(_ titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}
// MARK:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(_ pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setPageTitleViewProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}






