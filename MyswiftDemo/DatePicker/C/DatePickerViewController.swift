//
//  DatePickerViewController.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/7.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    
    
    var promptlist = [InputStruct("年月日分","",false,"",.default),
                      InputStruct("年月日","",false,"",.default)]
  
    
    var tableView: UITableView = UITableView()
   
    
    lazy var  lyjdatePick01:LYJDatePicker01 = {
        
        
        let datePick = LYJDatePicker01()
        
        return datePick
        
    }()//时间选择器01
    
    
    
    lazy var  lyjdatePick02:LYJDatePicker02 = {
        
        
        let datePick = LYJDatePicker02()
        
        return datePick
        
    }()//时间选择器02

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.setupUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    
    func setupUI()  {
        
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
        
        
        tableView.separatorStyle = .none//不显示分割线
        
        tableView.backgroundColor = UIColor.background
        
        tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0)
        
        tableView.estimatedRowHeight = commonCellHeight
        
        tableView.rowHeight = UITableViewAutomaticDimension
        //注册cell
        tableView.register(OutRegisterSubmitMainTableViewCell.self, forCellReuseIdentifier: OutRegisterSubmitMainTableViewCell.cellId)
        
        
        
        
        
    }
    
    func setTableViewF()  {
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
}





extension DatePickerViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    //MARK:UITableViewDelegate
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消第一响应者相应事件
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        
        switch indexPath.row {
        case 0:
            self.gotoDatePick02(index: indexPath)
        case 1:
            self.gotoDatePick(index: indexPath)
        default:
            self.gotoDatePick(index: indexPath)
        }
       
        
        
        
        
    }
    
    
    //MARK:打开时间选择
    
    func gotoDatePick(index:IndexPath)  {
        
        self.lyjdatePick01.canButtonReturnB = {
            
            debugPrint("我要消失了哈哈哈哈哈哈")
            self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
        }
        
        
        
        
        self.lyjdatePick01.sucessReturnB = { returnValue in
            
            
            self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
            debugPrint("我要消失了哈哈哈哈哈哈")
            
            
            //第二行
            var model = self.promptlist[ index.row]
            
            model.infoValue = returnValue
            
            
            self.promptlist[index.row] = model
            
            
            self.tableView.reloadData()
        }
        
        
        
        self.gototargetView(_targetView:self.lyjdatePick01)
        
    }
    
   
   //打开时间选择器02
    func gotoDatePick02(index:IndexPath)  {
        //需要初始化数据
        self.lyjdatePick02.initData()
        self.lyjdatePick02.canButtonReturnB = {
            
            debugPrint("我要消失了哈哈哈哈哈哈")
            self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
        }
        
        
        
        
        self.lyjdatePick02.sucessReturnB = { returnValue in
            
            
            self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewSlideBottomTop)
            debugPrint("我要消失了哈哈哈哈哈哈")
            
            
            //第二行
            var model = self.promptlist[ index.row]
            
            model.infoValue = returnValue
            
            
            self.promptlist[index.row] = model
            
            
            self.tableView.reloadData()
        }
        
        
        
        self.gototargetView(_targetView:self.lyjdatePick02)
        
    }
    
    
    //MARK:打开底部弹出view
    
    func gototargetView(_targetView:UIView)  {
        
        
        
        self.view.ttPresentFramePopupView(_targetView, animationType: TTFramePopupViewSlideBottomTop) {
            //            debugPrint("我要消失了")
        }
        
        _targetView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(250)
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
        
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: OutRegisterSubmitMainTableViewCell.cellId) as!  OutRegisterSubmitMainTableViewCell
        
        let dic:InputStruct  = promptlist[indexPath.row]
        
        let prompt = dic.infoLalbel
        
        
        
       
        cell.accessoryType = .disclosureIndicator
        
        
        cell.rowNum = indexPath.row
        
        cell.selectionStyle = .none
        
        
        cell.prompcouont = 6
        
        cell.returnInfoB = mainReturn
        
        cell.databind(inputStrct: dic, placeHolder: ("请输入\(prompt)" ), canEdit: dic.canEdit)
        
        return cell
      
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //MARK:主要的回调
    func mainReturn(text:String ,rowNum:Int) {
        
        
        var model = self.promptlist[rowNum ]
        
        
        model.infoValue = text
        
        self.promptlist[rowNum] = model
        
        
        
        debugPrint("传过来的text数据 \(text)")
        
        //        self.tableView.reloadData()
        
    }
    
    
    
   
    
    
}
