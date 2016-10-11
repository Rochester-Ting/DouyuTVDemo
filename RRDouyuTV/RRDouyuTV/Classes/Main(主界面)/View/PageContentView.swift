//
//  PageContentView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 11/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let contentCellId = "contentCellId"
class PageContentView: UIView {
    public var childVC : [UIViewController]
    public var parentVC : UIViewController
    // MARK:- 懒加载collectionView
    public lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        return collectionView
    }()
    init(frame: CGRect, childVC:[UIViewController] ,parentVC:UIViewController) {
        self.childVC = childVC
        self.parentVC = parentVC
        super.init(frame: frame)
        // MARK:- 设置UI
        setUpUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageContentView{
    public func setUpUI(){
        for vc in childVC {
            parentVC .addChildViewController(vc)
        }
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
    
}
// MARK:- 遵守数据源方法
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        for childVC in cell.contentView.subviews {
            childVC.removeFromSuperview()
        }
        //取出对应的vc
        let vc = childVC[indexPath.item]
        //设置vc的frame
        vc.view.frame = cell.bounds
        cell.contentView.addSubview(vc.view)
        return cell
    }
}
// MARK:- 遵守代理方法
extension PageContentView : UICollectionViewDelegate{
    
}
