//
//  CycleView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let kClycleCellId = "kClycleCellId"
class CycleView: UIView {
    // MARK:- 控件属性
    // collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    // 分页
    @IBOutlet weak var pageControl: UIPageControl!
    public lazy var recommandVM : RecommandViewModel = {
        let recommandVM = RecommandViewModel()
        return recommandVM
    }()
    var timer : Timer?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        // 注册
        collectionView.register(UINib.init(nibName: "CycleCell", bundle: nil), forCellWithReuseIdentifier: "kClycleCellId")
        // MARK:- 发送网络请求
        requestCycle()
        
    }
    class func cycleView()->CycleView{
        return Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)?.first as! CycleView
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 获取布局
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = self.bounds.size
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
    }
}

// MARK:- 遵守代理
extension CycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取当前偏移量
        let offSetX = scrollView.contentOffset.x
        // 获取当前的页码
        let num = Int(offSetX / kScreenW + 0.5)
        pageControl.currentPage = num % recommandVM.cycleArr.count
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
// MARK:- 遵守数据源
extension CycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(recommandVM.cycleArr.count) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kClycleCellId", for: indexPath) as! CycleCell
        cell.cycelModel = recommandVM.cycleArr[indexPath.item % recommandVM.cycleArr.count]
        return cell
    }
}
extension CycleView{
    // 发送网络请求
    func requestCycle(){
        recommandVM.requestCycle {
            self.pageControl.numberOfPages = self.recommandVM.cycleArr.count
            self.collectionView.reloadData()
            // MARK:- 初始化collectionView的位置
            let indexpath = IndexPath(item: self.recommandVM.cycleArr.count * 100, section: 0)
            self.collectionView.scrollToItem(at: indexpath, at: .left, animated: false)
            
            
            self.removeTimer()
            // MARK:- addTimer
            self.addTimer()
        }
    }
}
extension CycleView{
    // MARK:- 添加定时器
    func addTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
        // 将定时器添加到主循环中
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    // MARK:- 取消定时器
    func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    @objc fileprivate func timerUpdate(){
        // 获取现在的偏移量
        
        let nowOffset = collectionView.contentOffset.x
        let offSex = nowOffset + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offSex, y: 0), animated: true)
        
        
    }
}
