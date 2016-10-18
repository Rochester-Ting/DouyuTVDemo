//
//  AmuseHeadViewCell.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 18/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
fileprivate let kMargin : CGFloat = 20
fileprivate let leftMargin : CGFloat = 10
fileprivate let kgameCellId = "kgameCellId"
class AmuseHeadViewCell: UICollectionViewCell {
    var groups : [RGameModel]?{
        didSet{
            
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: kgameCellId)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemW = (collectionView.bounds.width) / 4
        let itemH = (collectionView.bounds.height) / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }
    
}
extension AmuseHeadViewCell : UICollectionViewDelegateFlowLayout{
}
extension AmuseHeadViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kgameCellId, for: indexPath) as! GameViewCell
        let url = URL(string: groups![indexPath.item].icon_url)
        cell.gameImage.kf.setImage(with: url)
        cell.titleNameLabel.text = groups![indexPath.item].tag_name
        cell.line.isHidden = true
        cell.clipsToBounds = true
        return cell
        
    }
    
}


