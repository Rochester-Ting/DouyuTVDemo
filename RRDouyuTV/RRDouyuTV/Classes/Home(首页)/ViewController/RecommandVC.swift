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
class RecommandVC: BaseViewController {
    
    var gameView : GameView?
    lazy var recommandVM : RecommandViewModel = RecommandViewModel()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(kClycleH + kGameViewH, 0, kStatusBarH + kNavigationH + kTitleViewH + kTabBarH, 0)
        self.collectionView = collectionView;
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        // MARK:- 注册Normal cell
        collectionView.register(UINib(nibName: "RecommandNormalCell", bundle: nil), forCellWithReuseIdentifier: kRecommandCellId)
        // MARK:- 注册颜值cell
        collectionView.register(UINib(nibName: "RecommanBeautifulCell", bundle: nil), forCellWithReuseIdentifier: kRecommandBeatifulCellId)
        // MARK:- 注册headView
        collectionView.register(UINib(nibName: "RecommandHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kRecommandSectionHeadId)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置背景颜色
        setBackGroundColor()
        // 添加collectionView
        setUpUI()
        // 获取数据
        GetNetwork()
        //添加轮播图
        addCycleView()
        //推荐游戏
        addGameView()
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
    public override func setUpUI(){
        
        contentView = collectionView
        view.addSubview(collectionView)
        super.setUpUI()
    }
}
// MARK:- 实现collectionView的数据源方法
extension RecommandVC : UICollectionViewDataSource{
    // 返回几组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommandVM.rGameModelArrs.count
    }
    // 返回每组有几个
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num = recommandVM.rGameModelArrs[section]
        
        return num.anchors.count
    }
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1{
            let cell : RecommanBeautifulCell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommandBeatifulCellId, for: indexPath) as! RecommanBeautifulCell
            cell.achor = recommandVM.rGameModelArrs[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
            return cell
        }else{
            let cell : RecommandNormalCell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommandCellId, for: indexPath) as! RecommandNormalCell
            cell.achor = recommandVM.rGameModelArrs[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
            return cell
        }
        
    }
    // 返回collectionView的headView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kRecommandSectionHeadId, for: indexPath) as! RecommandHeadView
//        headview.backgroundColor = UIColor.green
        headview.achorGame = recommandVM.rGameModelArrs[indexPath.section];
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
        recommandVM.requestHomeData {
            self.collectionView.reloadData()
            var gameArrs = self.recommandVM.rGameModelArrs
            gameArrs.removeFirst()
            gameArrs.removeFirst()
            let gameModel : RGameModel = RGameModel()
            gameModel.icon_name = "home_more_btn"
            gameModel.tag_name = "更多"
            gameArrs.append(gameModel)
            self.gameView?.gameArrs = gameArrs
            // 去掉动画
            self.stopAnimation()
        }
    }
}
// MARK:- 添加无限循环轮播图
extension RecommandVC{
    func addCycleView(){
        let cycleView = CycleView.cycleView()
        cycleView.frame = CGRect(x: 0, y: -(kClycleH + kGameViewH), width: kScreenW, height: kClycleH)
        collectionView.addSubview(cycleView)
    }
}
// MARK:- 添加GameView
extension RecommandVC{
    func addGameView(){
        let gameView = GameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        self.gameView = gameView
        collectionView.addSubview(gameView)
    }
}

