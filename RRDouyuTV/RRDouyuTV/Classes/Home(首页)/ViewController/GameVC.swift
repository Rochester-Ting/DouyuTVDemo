//
//  GameVC.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 17/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let kMargin : CGFloat = 10
private let kItemH : CGFloat = 90
private let kHeadViewH : CGFloat = 50
fileprivate let kgameCellId = "kgameCellId"
fileprivate let krecommadSectionId = "recommadSectionId"
class GameVC: UIViewController {
    var headCollectinView : GameView?
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenW - 2 * kMargin) / 3, height:  kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: kgameCellId)
        collectionView.register(UINib(nibName: "RecommandHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: krecommadSectionId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(kItemH + kHeadViewH, 0, kNavigationH + kStatusBarH + kTitleViewH + kTabBarH, 0)
        return collectionView
    }()
    fileprivate let gameVM : GameViewModel = GameViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        gameVM.requestGameData {[unowned self] in
            self.collectionView.reloadData()
            self.headCollectinView?.gameArrs = Array(self.gameVM.modelArrs[0..<10])
        }
        
        
    }
}
// MARK:- 设置UI
extension GameVC{
    func setUpUI() {
        view.addSubview(collectionView)
        automaticallyAdjustsScrollViewInsets = false
        let headCollectionView = GameView.gameView()
        self.headCollectinView = headCollectionView
        headCollectinView?.frame = CGRect(x: 0, y: -kItemH, width: kScreenW, height: kItemH)
        collectionView.addSubview(headCollectinView!)
        
        let topHead = RecommandHeadView.headView()
        topHead.frame = CGRect(x: 0, y: -(kHeadViewH + kItemH), width: kScreenW, height: kHeadViewH)
        topHead.image.image = UIImage(named: "Img_orange")
        topHead.tag_name.text = "常见游戏"
        topHead.btnMore.isHidden = true
        collectionView.addSubview(topHead)
        
    }
}
// MARK:- 遵守代理
extension GameVC : UICollectionViewDelegate{
    
}
// MARK:- 遵守数据源
extension GameVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.modelArrs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kgameCellId, for: indexPath) as! GameViewCell
        cell.gameModel = gameVM.modelArrs[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: krecommadSectionId, for: indexPath) as! RecommandHeadView
        headView.image.image = UIImage(named: "Img_orange")
        headView.tag_name.text = "全部游戏"
        headView.btnMore.isHidden = true
        return headView
    }
}


