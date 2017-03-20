//
//  ViewTableViewCell.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit


class ViewTableViewCell: UITableViewCell {

    static let cellId = "ViewTableViewCell"
    
   
    var content = UILabel()//显示
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    
    
    
    func setUI()  {
        self.addInfoLable()
        
        self.setContenF()
        
    }
    
    
    
    // MARK: lable显示
    private  func addInfoLable() {
        self.contentView.addSubview(content)
        self.setinfoLalbleP()
        
        self.setinfoLalbleF()
        
        
        
    }
    
    
    private func setinfoLalbleP() {
        content.textColor = TitlelableColor
        
        content.text = "测试数据"
        
        content.numberOfLines = 0
        
        
        content.textAlignment = .left
        
        content.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
    }
    
    
    private  func setinfoLalbleF() {
        
        content.snp.makeConstraints { (make) in
            
            make.leading.equalTo(self.contentView.snp.leading).offset(mycommonEdge)
            
            make.top.equalTo(self.contentView.snp.top).offset(mycommonEdge)
            
          
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-mycommonEdge)
            
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-mycommonEdge)
        }
        
        
    }
    
    
    
    func setinfoLalbleD( timeInfo:String)  {
        
        content.text = timeInfo
        
        
    }
    
    
    func setContenF(){
        contentView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.content.snp.bottom).offset(mycommonEdge)
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.trailing.equalTo(self)
            
            
        })
    }

    

}
