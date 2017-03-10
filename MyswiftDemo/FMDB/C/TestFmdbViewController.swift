//
//  TestFmdbViewController.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/13.
//  Copyright © 2017年 hand. All rights reserved.
//

import UIKit

class TestFmdbViewController: UIViewController {

    
    var tableView: UITableView = UITableView()
   
    
    lazy  var testmodel:TestModel = {
    
        let testmodel = TestModel()
        
        return testmodel
    }()
    
    
    
   let promptlist = ["插入TestTable","查询TestTable","修改TestTable","删除TestTable","dropTestTable"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUi()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setupUi()   {
        
        
        
        self.view.backgroundColor = UIColor.white
        
        self.addtableView()
        
    }
    
    
    func addtableView() {
        
        self.view.addSubview(tableView)
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
        
        tableView.estimatedRowHeight = commonCellHeight
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        //注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellId")
        
        
        
        
        
    }
    
    func setTableViewF()  {
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }

   
    
    
    

   

}




extension TestFmdbViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    //MARK:UITableViewDelegate
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        switch indexPath.row {
        case 0:
            self.insetTestModel()
        case 1:
            self.querytestmodel()
        case 2:
            self.updateTestmodel()
        case 3:
            self.deleteTestmodel()
        case 4:
            self.droptestTable()
            
        default:
            break
        }
    }
    
    
    func insetTestModel()  {
        
        let max: UInt32 = 100
        let min: UInt32 = 5
      let num  = arc4random_uniform(max - min) + min // 82
        
            self.testmodel.id2 = Double(num)
        
                if  self.testmodel.insertIntosqlite() {
                    debugPrint("保存成功")
                }else{
        
                    debugPrint("保存失败")
                }
        
    }
    
    func querytestmodel()  {
        
        let array =  self.testmodel.queryWithWhereStr(whereStr: nil, orderBy: nil)
        
    
        
        if let array = array {
            
            for model  in array {
            
                let model = model as! TestModel
                
                debugPrint("==modelid2==\(model.event)")
            }
            
            debugPrint("=====个数====\(array.count)")
        }else{
            
            
            debugPrint("错误了")
        }

        
    }
    
    //MARK:update
    
    func updateTestmodel()  {
        
        self.testmodel.name = "修改name"
        
        
        
        if  self.testmodel.updateWithWhereStr(whereStr: "fmdbid = 1") {
            debugPrint("修改成功")
        }else{
            
            debugPrint("修改失败")
        }

    }
    
    
    
    //MARK:删除
    
    func deleteTestmodel()  {
        
        
        
        if  self.testmodel.deleteWithWhereStr(whereStr: "fmdbid = 1")  {
            debugPrint("删除成功")
        }else{
            
            debugPrint("删除失败")
        }
        
    }
    
    
    //MARK:drop
    
    func droptestTable()  {
        
        
        
        if  self.testmodel.dropTable()  {
            debugPrint("drop成功")
        }else{
            
            debugPrint("drop失败")
        }
        
    }
    
    
    
    //MARK:UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return promptlist.count
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellId")
        
        cell?.textLabel?.text = promptlist[indexPath.row]
        
        
        return cell!
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
