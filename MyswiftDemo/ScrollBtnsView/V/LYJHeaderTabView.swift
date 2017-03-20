//
//  LYJHeaderTabView.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/27.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class LYJHeaderTabView: UIView {
    
     public var itemTitles = [String]()

    var tableView: UITableView = UITableView()
   
    
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
    
    
    func setup() {
        self.backgroundColor = UIColor.yellow
        
        self.addtableView()
        
    }
    
    func addtableView() {
        
        self.addSubview(tableView)
        self.setTableViewP()
        self.setTableViewF()
        
    }
    
    //MARK:设置tableView属性
    func setTableViewP()  {
        
        
        
        tableView.dataSource = self
        
        
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        
        
        tableView.backgroundColor = UIColor.background
        
        tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0)
        
//        tableView.estimatedRowHeight = commonCellHeight
        
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
         tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(M_PI_2))
        
    }
    
    func setTableViewF()  {
        
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        
        tableView.frame = frame
            }
    
    
    

    
}


extension LYJHeaderTabView: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
            return 1
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.itemTitles.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        cell?.textLabel?.text = self.itemTitles[indexPath.row]
       
        return UITableViewCell()
        
    }
    
    
    
    
  

}
