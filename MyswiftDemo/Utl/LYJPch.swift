//
//  LYJPch.swift
//  Colliers-CFIM
//
//  Created by Liyanjun on 2017/1/14.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//
import UIKit
import SnapKit



let myBlackColr = UIColor(hex: 0x424243)//常用的黑色

let mygrayColor = UIColor(hex: 0xb2b2b2)//常用的灰色


let TitlelableColor =  myBlackColr//系统常用的黑色





var keyWindow: UIWindow? {
    return UIApplication.shared.keyWindow
}

var isChinese: Bool {
    if let code = NSLocale.preferredLanguages.first, code.hasPrefix("zh") {
        return true
    }
    return false
}

var screenWidth:CGFloat {
    return UIScreen.main.bounds.width
}

var screenHeight:CGFloat {
    return UIScreen.main.bounds.height
}

//常用颜色

let TitleNameColor = mygrayColor //任务名字的颜色

let UnselectedColor = myBlackColr//头部导航未选中的颜色

let SelectedColor = UIColor.system//头部倒仰选中的颜色

let tableVlaueColor = myBlackColr //tableCell中间和底部的颜色

let mybuttonBlack = myBlackColr //一般按钮的黑色


let mybuttonBorderGray:UIColor = mygrayColor//按钮边框的灰色

let mypageCount = 10//分页的页数




//常用字体大小
let mylableSize = 15//设置常用字体大小为16

let mycommonEdge:CGFloat = 13//lable上下左右编剧

let bordertopbottom:CGFloat = 4 //borderview的上下编剧

let commonCellHeight = CGFloat(37.0 + 6)//常用tableCell的高度


let popViewH = CGFloat(23)//底部弹窗view的高度

let listlitalImgW:CGFloat = 18//列表小图标的宽度


let commontextViewHeight = commonCellHeight  - bordertopbottom*2 //通用textView的高度

let listimglablegap:CGFloat = 5//列表小图标的宽度

//MARK:可以输入的结构
struct InputStruct {
    
    var infoLalbel:String//左边
    
    var infoValue:String?//右边
    
    var canEdit:Bool//是否可编辑
    
    var infoValueId:String?//某些value的id
    
    var keyboardtype:UIKeyboardType
    
    init(_ infoLalbel:String,_ infoValue:String? , _ canEdit:Bool,_ infoId:String?,_ keybordertype:UIKeyboardType) {
        
        self.infoLalbel = infoLalbel
        
        self.canEdit = canEdit
        
        
        self.infoValue = infoValue ?? "  "
        
        self.infoValueId = infoId ?? "  "
        
        self.keyboardtype = keybordertype
    }
    
    
    
    
}










