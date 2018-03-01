//
//  HeaderTabViewCollectionViewCell.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/4/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

struct HeaderTabViewCollectionViewCellModel {
    var textStr:String
    
    var isSelectTed:Bool
    
    init() {
        self.textStr = ""
        
        self.isSelectTed = false
    }
    
    
    init(textStr:String, isSelectTed:Bool ) {
        self.textStr = textStr
        
        self.isSelectTed = isSelectTed

    }
    
}

class HeaderTabViewCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "HeaderTabViewCollectionViewCellId"
    
    var lineView:UIView = UIView()
    
    var textLable  = UILabel()
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupUI()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    
    private  func setupUI()  {
               self.contentView.backgroundColor = UIColor.yellow
        
        debugPrint("测试代码")
        
        
        self.contentView.addSubview(self.textLable)
        
        self.contentView.addSubview(self.lineView)
        
        self.textLableP()
        
        self.lineViewP()
        
        self.textLableF()
        
        self.lineViewF()
        
        self.setContenF()
        
    }
    
    
    
    private func textLableP(){
    
    
        self.textLable.font = UIFont.systemFont(ofSize: 15)
        
        self.textLable.textColor = SelectedColor
        
        self.textLable.text = "测试"
        
    }
    
    
    private func textLableF(){
    
    
        self.textLable.snp.makeConstraints { (make) in
            
            make.leading.equalTo(self.contentView)
            
            make.top.equalTo(self.contentView).offset(8)
            
            make.trailing.equalTo(self.contentView.snp.trailing).priority(600)
            
        make.bottom.equalTo(self.contentView.snp.bottom).offset(-8).priority(600)
        }
    
    
    }
    
    
    private  func lineViewP()  {
        
        self.lineView.backgroundColor =  SelectedColor
        
        
    }
    
    private func lineViewF(){
    
    
        self.lineView.snp.makeConstraints { (make) in
            make.width.leading.equalTo(self.textLable)
            make.height.equalTo(4)
            make.top.equalTo(self.textLable.snp.bottom).offset(4)
        }
    
    }
    
    
    func setContenF(){
        contentView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self)
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.trailing.equalTo(self)
            
            
        })
    }
    
    
//MARK:加载数据
    
    func dataBind(model:HeaderTabViewCollectionViewCellModel )  {
        
        self.textLable.text = model.textStr
        
        self.lineView.isHidden = !model.isSelectTed
        
    }
    
    
    
}
