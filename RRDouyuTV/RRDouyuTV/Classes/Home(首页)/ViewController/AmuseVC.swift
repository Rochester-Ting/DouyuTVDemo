//
//  AmuseVC.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 17/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
fileprivate let kCellId = "kCellId"
fileprivate let kMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenW - 3 * kMargin) / 2
private let kItemHeight : CGFloat = kItemWidth * 3 / 4
fileprivate let kHeadId = "recommadSectionId"
private let kHeadViewH : CGFloat = 50
private let kAmuseHeadViewH : CGFloat = 200
class AmuseVC: BaseViewController {
    let amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate var amuseHeadView : AmuseHeadView = {
        let amuseHeadView = AmuseHeadView.amuseHeadView()
        amuseHeadView.frame = CGRect(x: 0, y: -kAmuseHeadViewH, width: kScreenW, height: kAmuseHeadViewH)
        return amuseHeadView
    }()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: kScreenW, height:kHeadViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "RecommandNormalCell", bundle: nil), forCellWithReuseIdentifier: kCellId)
        collectionView.register(UINib(nibName: "RecommandHeadView", bundle: nil),forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadId)
        collectionView.contentInset = UIEdgeInsets(top: kAmuseHeadViewH, left: 0, bottom: kStatusBarH + kNavigationH + kTitleViewH + kTabBarH, right: 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
       // MARK:- 发送请求
        requestData()
    }
}
extension AmuseVC{
    override func setUpUI(){
//        super.setUpUI()
        view.addSubview(collectionView)
        collectionView.addSubview(amuseHeadView)
        automaticallyAdjustsScrollViewInsets = false
        
        contentView = collectionView
        super.setUpUI()

    }
    func requestData(){
        self.amuseVM.requestAmuseData {
            self.collectionView.reloadData()
            var groups : [RGameModel] = self.amuseVM.amuseModels
            groups.removeFirst()
            self.amuseHeadView.groups = groups
            
            self.stopAnimation()
        }
    }
}
extension AmuseVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isVertical = amuseVM.amuseModels[indexPath.section].anchors[indexPath.item].isVertical
        isVertical == 0 ? pushVC() : presentVC()
    }
    func pushVC() {
        navigationController?.pushViewController(RoomNormalVC(), animated: true)
    }
    func presentVC(){
        present(RoomBeatifulVC(), animated: true, completion: nil)
        
    }
    
}
extension AmuseVC : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.amuseModels.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.amuseModels[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellId, for: indexPath) as! RecommandNormalCell
        cell.achor = amuseVM.amuseModels[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadId, for: indexPath) as! RecommandHeadView
        headView.tag_name.text = self.amuseVM.amuseModels[indexPath.section].tag_name
        headView.image.image = UIImage(named: "home_header_normal")
        if amuseVM.amuseModels[indexPath.section].anchors.count == 0{
            headView.isHidden = true
        }else{
            headView.isHidden = false
        }
        
        return headView
        
    }
}







