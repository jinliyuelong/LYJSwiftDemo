//
//  LYJDatePicker02.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/8.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

/// 这是时间选择器，实现 yyyy-mm-dd HH:mi:ss
class LYJDatePicker02: UIView {

    var canButtonReturnB: (() -> Void)? //取消按钮的回调
    
    var sucessReturnB: ((_ date:String) -> Void)?//选择的回调
    
    
    var title = UILabel.init(lableText: "选择时间")//标题
    
    var cancelButton = UIButton.init(title: "取消", bgColor: UIColor.clear, font:  CGFloat(mylableSize)) //取消按钮
    
    var confirmButton = UIButton.init(title: "确定", bgColor: UIColor.clear, font:  CGFloat(mylableSize)) //取消按钮
    
    
    var pickerView = UIPickerView()
    
    
     var lineView = UIView()//一条横线
    
    var returnString:String  {
    
        get{
            
            let selectedMonthFormat = String(format:"%.2d",selectedMonth)
        
            let selectedDayFormat = String(format:"%.2d",selectedDay)
        
            
            let selectedHourFormat = String(format:"%.2d",selectedHour)
            
            let selectedMinuteFormat = String(format:"%.2d",selectedMinute)
            

            
            return "\(selectedYear)-\(selectedMonthFormat)-\(selectedDayFormat) \(selectedHourFormat):\(selectedMinuteFormat)"
        
            
        }
    
        
    } //返回的时间字符串
    
    

    
    //数据相关
    var yearRange = 30 + 1000//年的范围
    
    var dayRange = 0 //
    
    
    var startYear = 0
    
    var selectedYear = 0;
    var selectedMonth = 0;
    var selectedDay = 0;
    var selectedHour = 0;
    var selectedMinute = 0;
    var selectedSecond = 0;
    
 
    
    
    
    
   
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
        
    }
    
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        self.setupUI()
        
    
        
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:初始化数据
    func initData()  {
        
        
        
        let  calendar0 = Calendar.init(identifier: .gregorian)//公历
        
        var comps = DateComponents()//一个封装了具体年月日、时秒分、周、季度等的类
        
        let unitFlags:Set<Calendar.Component> = [.year , .month , .day , .hour , .minute]
        
        
   
        
        comps = calendar0.dateComponents(unitFlags, from: Date())
        
        startYear = comps.year! - 100
        
        
        
        dayRange = self.isAllDay(year: startYear, month: 1)
        
        yearRange = 30 + 1000;
        selectedYear = comps.year!;
        selectedMonth = comps.month!;
        selectedDay = comps.day!;
        selectedHour = comps.hour!;
        selectedMinute = comps.minute!;
        
        
        self.pickerView.selectRow(selectedYear - startYear, inComponent: 0, animated: true)
        
        
        self.pickerView.selectRow(selectedMonth - 1, inComponent: 1, animated: true)
        

        self.pickerView.selectRow(selectedDay - 1, inComponent: 2, animated: true)
       
        
        self.pickerView.selectRow(selectedHour , inComponent: 3, animated: true)
       
        
        self.pickerView.selectRow(selectedMinute , inComponent: 4, animated: true)
        
        
        self.pickerView.reloadAllComponents()
        
      

    }
    
    
    func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        self.addtitle()
        
        self.addcancelButton()
        
        self.addlineView()
        
        self.addconfirmButton()
        
       self.addPickerView()
        
    }
    
    
    
    
    //MARK:设置标题
    private func addtitle(){
        
        
        self.addSubview(title)
        
        self.titleP()
        self.titleF()
        
        
        
    }
    
    
    
    private func titleP(){
        title.textColor = TitlelableColor
        
        title.textAlignment = .center
        
        title.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
        
        
    }
    
    
    
    private func titleF(){
        title.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.centerX.equalTo(self.snp.centerX)
            
        }
        
    }
    
    
    
    private func titleD(title:String){
        
        self.title.text = title
    }
    
    
    //MARK:设置取消按钮
    private func addcancelButton(){
        
        self.addSubview(cancelButton)
        
        self.cancelP()
        
        self.cancelF()
    }
    
    private func cancelP(){
        
        self.cancelButton.setTitleColor(UIColor.system, for: .normal)
        self.cancelButton.tag = 101
        self.cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
    }
    
    private func cancelF(){
        
        self.cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.leading.equalTo(self.snp.leading).offset(mycommonEdge)
            
            make.height.equalTo(mylableSize)
            
            make.width.equalTo(40)
            
        }
        
    }
    
    private func cancelD(){
        
    }
    
    
    
    //MARK:设置确定按钮
    private func addconfirmButton(){
        
        self.addSubview(confirmButton)
        
        self.confirmButtonP()
        
        self.confirmButtonF()
    }
    
    private func confirmButtonP(){
        
        self.confirmButton.setTitleColor(UIColor.system, for: .normal)
        self.confirmButton.tag = 102
        self.confirmButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
    }
    
    private func confirmButtonF(){
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.trailing.equalTo(self.snp.trailing).offset(-mycommonEdge)
            
            make.height.equalTo(mylableSize)
            
            make.width.equalTo(40)
            
        }
        
    }
    
    
    
    
    //MARK:按钮的点击
    func buttonClick(_ sender:UIButton) {
        debugPrint("======取消按钮被点击=====")
        
        
        switch sender.tag {
        case 101:
            //取消
            if self.canButtonReturnB != nil {
                
                self.canButtonReturnB!()
            }
        case 102:
            //确定
            if self.sucessReturnB != nil {
                
                self.sucessReturnB!(self.returnString)
                
            }
            
            
        default:
            break
        }
        
        
        
        
    }
    
    
    
    //MARK:设置横线
    private func addlineView(){
        
        self.addSubview(lineView)
        
        self.lineViewP()
        
        self.lineViewF()
        
    }
    
    private func lineViewP(){
        
        self.lineView.backgroundColor = UIColor.systemGray
        
        
    }
    
    private func lineViewF(){
        
        self.lineView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.cancelButton.snp.bottom).offset(mycommonEdge)
            
            make.leading.trailing.equalTo(self)
            
            make.height.equalTo(1)
            
            
        }
        
    }

    
    
    func addPickerView()  {
        
        self.addSubview(self.pickerView)
        
        self.setPickerP()
        
        self.setPickerF()
    }
    
    func setPickerP()  {
        
        self.pickerView.dataSource = self
        
        self.pickerView.delegate = self
    }
    
    func setPickerF()  {
        
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom)
            
            make.leading.trailing.bottom.equalTo(self)
            
        }
    }
    
    //MARK:计算每个月有多少天
    
    func isAllDay(year:Int, month:Int) -> Int {
        
      var   day:Int = 0
        switch(month)
        {
        case 1,3,5,7,8,10,12:
            day = 31
        case 4,6,9,11:
            day = 30
        case 2:
            
                if(((year%4==0)&&(year%100==0))||(year%400==0))
                {
                    day=29
                
                }
                else
                {
                    day=28;
            
                }
           
        default:
            break;
        }
        return day;
    }
    
    


}





extension  LYJDatePicker02:UIPickerViewDelegate,UIPickerViewDataSource{

 //MARK:UIPickerViewDataSource
    //返回UIPickerView当前的列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    ////确定每一列返回的东西
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return yearRange
        case 1:
            return 12
        case 2:
            return dayRange
        case 3:
            return 24
        case 4:
            return 60
        default:
            return 0
        }
        
       
    }

    //MARK:UIPickerViewDelegate

    //返回一个视图，用来设置pickerView的每行显示的内容。
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
       
        let label  = UILabel(frame: CGRect(x: screenWidth * CGFloat(component) / 6 , y: 0, width: screenWidth/6, height: 30))
        
        label.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
        label.tag = component*100+row
        
        label.textAlignment = .center
        
        switch component {
        case 0:
            
            label.frame=CGRect(x:5, y:0,width:screenWidth/4.0, height:30);
            
           
            label.text="\(self.startYear + row)年";
            
        case 1:
            
            label.frame=CGRect(x:screenWidth/4.0, y:0,width:screenWidth/8.0, height:30);
            
            
            label.text="\(row + 1)月";
        case 2:
            
            label.frame=CGRect(x:screenWidth*3/8, y:0,width:screenWidth/8.0, height:30);
            
            
            label.text="\(row + 1)日";
        case 3:
            
           label.textAlignment = .right
            
            label.text="\(row )时";
        case 4:
            
            label.textAlignment = .right
            
            label.text="\(row )分";
        case 5:
            
            label.textAlignment = .right
            
            label.frame=CGRect(x:screenWidth/6, y:0,width:screenWidth/6.0 - 5, height:30);
           
            
            label.text="\(row )秒";
     
        default:
            label.text="\(row )秒";
        }
        
        
        
        
        return label
        
        
    }
    
    
    //当点击UIPickerView的某一列中某一行的时候，就会调用这个方法
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            self.selectedYear = self.startYear + row
            
            self.dayRange = self.isAllDay(year: self.startYear, month: self.selectedMonth)
            
            self.pickerView.reloadComponent(2)
        case 1:
            self.selectedMonth =  row + 1
            
            self.dayRange = self.isAllDay(year: self.startYear, month: self.selectedMonth)
            
            self.pickerView.reloadComponent(2)
        case 2:
            selectedDay = row + 1
        case 3:
            selectedHour = row
        case 4:
            selectedMinute = row
        case 5:
            selectedSecond = row
        default:
            selectedSecond = row

        }
        
        
    }

}
