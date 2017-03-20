//
//  ScrollBtnsView.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/27.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

import UIKit

protocol TapItemDelegate {
    func tapItem(index: Int)
}

class HeaderTabView: UIView {
    
    
    public var itemTitles = [String]()
    var delegate: TapItemDelegate?
    
    var fullwidth:CGFloat = 0
    
    private var itemNumber: Int = 0
    private var currentItemIndex: Int = 0
    private var scrollView = UIView()
    private var selectedColor = SelectedColor
    private var unselectedColor = UnselectedColor
    private var buttons = [UIButton]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, itemTitles: [String] ) {
        super.init(frame: frame)
        self.itemTitles = itemTitles
        setup()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    func reloadUi()  {
        
        var   i = 0
        for button in self.buttons{
            
            button.setTitle(itemTitles[i], for: .normal)
            
            i += 1
            
        }
    }
    
    
    func setup() {
        self.backgroundColor = UIColor.white
        
        itemNumber = itemTitles.count
        let itemWidth = screenWidth/CGFloat(itemNumber)
        let itemHeight = self.frame.height
        
        for index in 0 ..< itemNumber {
            let button = UIButton(frame: CGRect(x: CGFloat(index) * itemWidth, y: 0, width: itemWidth, height: itemHeight))
            button.setTitle(itemTitles[index], for: .normal)
            button.titleLabel?.sizeToFit()
            
            self.fullwidth += (button.titleLabel?.frame.width)!
            
            button.tag = index
            button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            if index == 0 {
                button.setTitleColor(selectedColor, for: .normal)
            } else {
                button.setTitleColor(unselectedColor, for: .normal)
            }
            self.buttons.append(button)
            self.addSubview(button)
            
        }
        
        debugPrint("应该的宽度是\(self.fullwidth),屏幕宽度是。。\(screenWidth)")
        
        scrollView.frame = getScrollViewFrame()
        scrollView.backgroundColor = selectedColor
        self.addSubview(scrollView)
        
        let sepView1 = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 0.5))
        sepView1.backgroundColor = UIColor.systemGray
        let sepView2 = UIView(frame: CGRect(x: 0, y: self.frame.height - 0.5, width: screenWidth, height: 0.5))
        sepView2.backgroundColor = UIColor.systemGray
        self.addSubview(sepView1)
        self.addSubview(sepView2)
    }
    
    func tapButton(_ sender: UIButton) {
        let tag = sender.tag
        guard tag != currentItemIndex else {
            return
        }
        
        self.buttons[currentItemIndex].setTitleColor(unselectedColor, for: .normal)
        self.currentItemIndex = tag
        self.buttons[currentItemIndex].setTitleColor(selectedColor, for: .normal)
        self.delegate?.tapItem(index: tag)
        scrollSubView(index: tag)
        
    }
    
    func getScrollViewFrame() -> CGRect {
        
        let button = self.buttons[currentItemIndex]
        button.titleLabel!.sizeToFit()
        var labelWidth = button.titleLabel!.frame.width
        labelWidth = labelWidth < 50 ? 50 : labelWidth
        let itemHeight = self.frame.height
        let itemWidth = screenWidth/CGFloat(self.itemNumber)
        let originX = (itemWidth - labelWidth)/2
        
        return CGRect(x: itemWidth * CGFloat(currentItemIndex) + originX, y: itemHeight - 4, width: labelWidth, height: 4)
        
    }
    
    func scrollSubView(index: Int) {
        UIView.animate(withDuration: 0.1, delay:0, options:UIViewAnimationOptions.beginFromCurrentState, animations:
            { ()-> Void in
                self.scrollView.frame = self.getScrollViewFrame()
        }, completion: nil
        )
        
    }
    
    
}
