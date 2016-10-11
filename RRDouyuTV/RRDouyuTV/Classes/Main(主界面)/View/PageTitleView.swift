//
//  PageTitleView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 11/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
private let kLineH : CGFloat = 2
private let kBottomLine : CGFloat = 0.5
class PageTitleView: UIView {
    // MARK:- 保存label的数组
    public lazy var labels : [UILabel] = [UILabel]()
    // MARK:- 文字的数组
    public var titles : [String]
    // MARK:- 懒加载scrollView
    public lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    // MARK:- 创建构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles;
        super.init(frame: frame)
        // MARK:- 设置UI
        setUpUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitleView{
    public func setUpUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        // MARK:- 添加文字
        addTitleLabel()
        // MARK:- 添加下面的线
        addBottomLineAndScrollBottomLine()
    }
    private func addTitleLabel() {
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.text = title
            label.textAlignment = .center
            // MARK:- 设置label的frame
            let labelW : CGFloat = scrollView.frame.width / CGFloat(titles.count)
            let labelH : CGFloat = frame.height - kLineH
            let labelX : CGFloat = labelW * CGFloat(index)
            let labelY : CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            labels.append(label)
        }
    }
    private func addBottomLineAndScrollBottomLine(){
        // MARK:- 最下面的灰色的线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        addSubview(bottomLine)
        let bottomLineW : CGFloat = kScreenW
        let bottomLineH : CGFloat = kBottomLine
        let bottomLineX : CGFloat = 0
        let bottomLineY : CGFloat = frame.height - kBottomLine
        bottomLine.frame = CGRect(x: bottomLineX, y: bottomLineY, width: bottomLineW, height: bottomLineH)
        
        // MARK:- 设置ScrollView下面的黄线
        let scrollBottomLine = UIView()
        scrollBottomLine.backgroundColor = UIColor.orange
        guard let firstLable = labels.first else {
            return
        }
        firstLable.textColor = UIColor.orange
        let scrollBottomLineW  = firstLable.frame.width
        let scrollBottomLineH  = kLineH
        let scrollBottomLineX  = firstLable.frame.origin.x
        let scrollBottomLineY  = frame.height - kLineH
        
        scrollBottomLine.frame = CGRect(x: scrollBottomLineX, y: scrollBottomLineY, width: scrollBottomLineW, height: scrollBottomLineH)
        scrollView.addSubview(scrollBottomLine)
    }
}
