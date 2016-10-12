//
//  PageContentView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 11/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(pageContentView : PageContentView,progress:CGFloat,sourceIndex: Int,targetIndex : Int)
}
private let contentCellId = "contentCellId"
class PageContentView: UIView {
    public var childVC : [UIViewController]
    public var parentVC : UIViewController
    public var startOffsetX : CGFloat
    public var isForbidDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
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
        self.startOffsetX = 0
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if  isForbidDelegate  {
            return
        }
        // 获取滑动的比例
        var progress : CGFloat = 0
        // 获取当前的label的tag
        var sourceIndex : Int = 0
        // 获取目标label的tag
        var targetIndex : Int = 0
        let scrollViewW = scrollView.frame.width
        
        if startOffsetX < scrollView.contentOffset.x { // 左划
            progress = scrollView.contentOffset.x / scrollViewW - floor(scrollView.contentOffset.x / scrollViewW)
            sourceIndex = Int(scrollView.contentOffset.x / scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVC.count {
                targetIndex = childVC.count - 1
            }
            
            // MARK:- 如果划过去以后改变当前的label和目标的label
            if (scrollView.contentOffset.x - startOffsetX) == scrollViewW  {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右划
            progress = 1 - (scrollView.contentOffset.x / scrollViewW - floor(scrollView.contentOffset.x / scrollViewW))
            targetIndex = Int(scrollView.contentOffset.x / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex > childVC.count {
                sourceIndex = childVC.count - 1
            }
        }
        delegate?.pageContentView(pageContentView:self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
// MARK:- 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int){
        isForbidDelegate = true
        let offSet = kScreenW * CGFloat(currentIndex)
        collectionView.setContentOffset(CGPoint(x:offSet, y:0), animated: true)
    }
}
