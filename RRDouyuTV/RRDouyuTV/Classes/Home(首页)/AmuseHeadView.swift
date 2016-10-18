//
//  AmuseHeadView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 17/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
fileprivate let kgameCellId = "kgameCellId"
class AmuseHeadView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var groups : [RGameModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "AmuseHeadViewCell", bundle: nil), forCellWithReuseIdentifier: kgameCellId)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kgameCellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
    }
    class func amuseHeadView()->AmuseHeadView{
        return Bundle.main.loadNibNamed("AmuseHeadView", owner: nil, options: nil)?.first as! AmuseHeadView
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}
extension AmuseHeadView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / collectionView.bounds.width + 0.5)
    }
}
extension AmuseHeadView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0}
        let num = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = num
        return num
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kgameCellId, for: indexPath) as! AmuseHeadViewCell
        cell.backgroundColor = UIColor.randomColor()
        // 取出起始位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        if endIndex > groups!.count - 1{
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
        return cell
    }
    
}
