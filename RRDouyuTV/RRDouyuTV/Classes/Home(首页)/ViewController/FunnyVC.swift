//
//  FunnyVC.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 18/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kItemHeight : CGFloat = kItemWidth * 3 / 4
fileprivate let kNormalCellId = "kNormalCellId"
class FunnyVC: BaseViewController {
    let funnyVM : FunnyViewModel = FunnyViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "RecommandNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.contentInset = UIEdgeInsets(top: kItemMargin, left: 0, bottom: kStatusBarH + kNavigationH + kTabBarH + kTitleViewH, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
        
        setUpUI()
    }
    
    
    
}
extension FunnyVC{
    override func setUpUI() {
//        super.setUpUI()
        view.addSubview(collectionView)
        contentView = collectionView
        super.setUpUI()

        funnyVM.requestFunnyData {
            self.collectionView.reloadData()
            self.stopAnimation()
        }
    }
}

extension FunnyVC : UICollectionViewDelegate{
    
}
extension FunnyVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyVM.funnyModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! RecommandNormalCell
        cell.achor = funnyVM.funnyModels[indexPath.row]
        return cell
    }
}











