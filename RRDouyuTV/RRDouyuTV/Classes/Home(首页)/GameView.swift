//
//  GameView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
fileprivate let kgameCellId = "kgameCellId"
fileprivate let kItemSize = 70
fileprivate let kMargin = 10
class GameView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    var gameArrs : [RGameModel]?{
        didSet {
            gameArrs?.removeFirst()
            gameArrs?.removeFirst()
            let gameModel : RGameModel = RGameModel()
            gameModel.icon_name = "home_more_btn"
            gameModel.tag_name = "更多"
            gameArrs?.append(gameModel)
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: kgameCellId)
        collectionView.contentInset = UIEdgeInsetsMake(0, CGFloat(kMargin), 0, CGFloat(kMargin))
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    class func gameView()->GameView{
        return Bundle.main.loadNibNamed("GameView", owner: nil, options: nil)?.first as! GameView
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kItemSize, height: kItemSize)
        layout.minimumLineSpacing = CGFloat(kMargin)
        layout.minimumInteritemSpacing = CGFloat(kMargin)
        layout.scrollDirection = .horizontal
    }
}
extension GameView : UICollectionViewDelegate{
    
}

extension GameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArrs?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kgameCellId, for: indexPath) as! GameViewCell
    
        cell.gameModel = gameArrs![indexPath.item]
        return cell
    }
}
