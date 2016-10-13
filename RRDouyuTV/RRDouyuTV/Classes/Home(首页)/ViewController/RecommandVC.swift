//
//  RecommandVC.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 13/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemHeight : CGFloat = kItemWidth * 3 / 4
private let kItemBeatifulHeight : CGFloat = kItemWidth * 4 / 3
// cell的id
private let kRecommandCellId = "recommadCell"
private let kRecommandBeatifulCellId = "recommadBeatifulCell"
private let kRecommandSectionHeadId = "recommadSectionId"
// sectionHead的高度
private let kHeadViewH : CGFloat = 50
class RecommandVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置背景颜色
        setBackGroundColor()
        // 添加collectionView
        addCollectionView()
        // 获取数据
        GetNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension RecommandVC{
    // MARK:- 设置背景颜色
    public func setBackGroundColor(){
        view.backgroundColor = UIColor.white
    }
    // MARK:- 设置collectionView
    public func addCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, kStatusBarH + kNavigationH + kTitleViewH + kTabBarH, 0)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        // MARK:- 注册Normal cell
        collectionView.register(UINib(nibName: "RecommandNormalCell", bundle: nil), forCellWithReuseIdentifier: kRecommandCellId)
        // MARK:- 注册颜值cell
        collectionView.register(UINib(nibName: "RecommanBeautifulCell", bundle: nil), forCellWithReuseIdentifier: kRecommandBeatifulCellId)
        // MARK:- 注册headView
        collectionView.register(UINib(nibName: "RecommandHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommandSectionHeadId)
        view.addSubview(collectionView)
    }
}
// MARK:- 实现collectionView的数据源方法
extension RecommandVC : UICollectionViewDataSource{
    // 返回几组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    // 返回每组有几个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommandBeatifulCellId, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommandCellId, for: indexPath)
        }
        return cell
    }
    // 返回collectionView的headView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommandSectionHeadId, for: indexPath)
//        headview.backgroundColor = UIColor.green
        return headview
    }
}
// MARK:- 遵守UICollectionViewDelegateFlowLayout
extension RecommandVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kItemBeatifulHeight)
        }else{
            return CGSize(width: kItemWidth, height: kItemHeight)
        }
    }
}
// MARK:- 获取网络数据
extension RecommandVC{
    func GetNetwork() {
        RecommandViewModel.requestHomeData()
    }
}



