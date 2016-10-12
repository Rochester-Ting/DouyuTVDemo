//
//  PageTitleView.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 11/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
// MARK:- 设置代理
protocol PageTitleViewDelegate : class{
    func pageTitleView(_ titleView: PageTitleView, selectIndex index : Int)
}
private let kLineH : CGFloat = 2
private let kBottomLine : CGFloat = 0.5
class PageTitleView: UIView {
    // MARK:- 设置代理的属性
    weak var delegate : PageTitleViewDelegate?
    // MARK:- 设置当前被选中的label
    open lazy var selectLabel : UILabel = UILabel()
    // MARK:- 设置滑动的orange的线
    open lazy var scrollBottomLine : UIView = UIView()
    // MARK:- 保存label的数组
    open lazy var labels : [UILabel] = [UILabel]()
    // MARK:- 文字的数组
    open var titles : [String]
    // MARK:- 懒加载scrollView
    open lazy var scrollView : UIScrollView = {
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
    fileprivate func addTitleLabel() {
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.text = title
            label.textAlignment = .center
            label.tag = index
            // MARK:- 设置label的frame
            let labelW : CGFloat = scrollView.frame.width / CGFloat(titles.count)
            let labelH : CGFloat = frame.height - kLineH
            let labelX : CGFloat = labelW * CGFloat(index)
            let labelY : CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            labels.append(label)
            
            label.isUserInteractionEnabled = true
            let ges = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(ges)
        }
    }
    fileprivate func addBottomLineAndScrollBottomLine(){
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
        self.scrollBottomLine = scrollBottomLine
        scrollBottomLine.backgroundColor = UIColor.orange
        guard let firstLable = labels.first else {
            return
        }
        selectLabel = firstLable
        firstLable.textColor = UIColor.orange
        let scrollBottomLineW  = firstLable.frame.width
        let scrollBottomLineH  = kLineH
        let scrollBottomLineX  = firstLable.frame.origin.x
        let scrollBottomLineY  = frame.height - kLineH
        
        scrollBottomLine.frame = CGRect(x: scrollBottomLineX, y: scrollBottomLineY, width: scrollBottomLineW, height: scrollBottomLineH)
        scrollView.addSubview(scrollBottomLine)
    }
}
extension PageTitleView{
    @objc public func titleLabelClick(_ tap :UITapGestureRecognizer){
        // MARK:- 获取当前点击的label
        guard let currentLabel = tap.view as? UILabel else {return}
        selectLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor.orange
        selectLabel = currentLabel
        // MARK:- 设置下面的横线滑动
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollBottomLine.frame.origin.x = CGFloat(currentLabel.tag) * currentLabel.frame.width
            
            })
        delegate?.pageTitleView(self, selectIndex: currentLabel.tag)
    }
}
// MARK:- 对外暴露的方法
extension PageTitleView{
    func setPageTitleViewProgress(_ progress : CGFloat,sourceIndex: Int,targetIndex:Int) {
        // 取出当前的label的目标的label
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        // 总共滑动的距离
        let moveTotal = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        // scrollBottomLine滑动的距离
        let moveX = moveTotal * progress

        // 让线移动
        scrollBottomLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        if progress >= 0.5 {
            sourceLabel.textColor = UIColor.darkGray
            targetLabel.textColor = UIColor.orange
            selectLabel = targetLabel
        }
    }
}

