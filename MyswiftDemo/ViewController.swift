//
//  ViewController.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableCells = [QRcodeViewController.init(title: "二维码(只支持真机)"),
                      SignatureViewController.init(title: "签名"),
                      DatePickerViewController.init(title: "常用日期控件"),
                      TestFmdbViewController.init(title: "FMDB"),
                      HeaderViewController.init(title: "头部导航"),


                      ]
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    func setUpUI()  {
        
        self.setTableViewP()
//        self.tableView.reloadData()
        
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
        tableView.register(ViewTableViewCell.self, forCellReuseIdentifier: ViewTableViewCell.cellId)
        
        
        
        
    }
    

}



extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    //MARK:UITableViewDelegate
    
    
    
    
    
    //MARK:UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.tableCells.count
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewTableViewCell.cellId)! as!  ViewTableViewCell
            
            
            cell.selectionStyle = .none
        
        cell.accessoryType = .disclosureIndicator//设置箭头
        
        
            cell.setinfoLalbleD(timeInfo: tableCells[indexPath.row].title!)
            
        
        
        
            return cell
       
            
       
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = self.tableCells[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
}




