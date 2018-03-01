//
//  ScrollBtnsView.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/27.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

protocol TapItemDelegate {
    func tapItem(index: Int)
}


enum HeaderTabViewType:Int {
    case HeaderTabViewShortType = 0 //没有越过屏幕的
    case HeaderTabViewLongType = 1//需要collectionView 的
}


class HeaderTabView: UIView {
    
    
    public var itemTitles = [String]()
    var delegate: TapItemDelegate?
    
    private var viewType:HeaderTabViewType = .HeaderTabViewShortType
    
    private var itemNumber: Int = 0
    private var currentItemIndex: Int = 0
    //    private var scrollView = UIView()//HeaderTabViewShortType 的view
    
    lazy  private var scrollView:UIView = {
        
        return UIView()
    }()//HeaderTabViewShortType 的view
    
    private var selectedColor = SelectedColor
    private var unselectedColor = UnselectedColor
    private var buttons = [UIButton]()
    
    
    
    //MARK:这是collecitonView的地方
    
    var dataSourcemodel:Array<HeaderTabViewCollectionViewCellModel>?
    
    var dataSourceCopy:Array<HeaderTabViewCollectionViewCellModel>?
    
    
    lazy  var flowLayout:UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = 0 //横线间距
        
        layout.minimumLineSpacing = 0//总线
        
        layout.estimatedItemSize = CGSize.init(width: 10, height: 10)
        
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0)
        
        return layout
        
    }()
    
    
    lazy   var collectionView:UICollectionView = {
        let collectionView:UICollectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: self.flowLayout)
        
        
        
        
        
        return collectionView
    }()//HeaderTabViewLongType 的view
    
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, itemTitles: [String] ) {
        super.init(frame: frame)
        self.itemTitles = itemTitles
        self.viewType = .HeaderTabViewShortType
        setup()
    }
    
    
    init(frame: CGRect, itemTitles: [String] ,viewType:HeaderTabViewType) {
        super.init(frame: frame)
        self.itemTitles = itemTitles
        self.viewType = viewType
        setupLongUi()
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
    
    
    
    func masScale(x:Float) -> Float {
        
        let width  = Float(screenWidth)
        
        
        return x * width / 320
    }
    
    //MARK:这是collecitonView的地方
   
    
    func collectionviewP()  {
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = UIColor.red
        
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.register(HeaderTabViewCollectionViewCell.self, forCellWithReuseIdentifier: HeaderTabViewCollectionViewCell.cellId)
        
        

    }

    func collectionviewF()  {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
   
    
    func setupLongUi()  {
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.collectionView)
        
        self.collectionviewP()
        
        self.collectionviewF()
        
       let count  =  self.itemTitles.count - 1
        
        self.dataSourcemodel = Array()
        
       self.dataSourceCopy = Array()
        
        self.dataSourcemodel?.removeAll()
        self.dataSourceCopy?.removeAll()
        
        for index in 0...count {
            var model = HeaderTabViewCollectionViewCellModel.init(textStr: self.itemTitles[index], isSelectTed: false)
            
            self.dataSourceCopy?.append(model)
            
            if index == 0 {
                model.isSelectTed = true
            }
            self.dataSourcemodel?.append(model)
            
            
        }
        
       self.collectionView.reloadData()
    }
    
    
}


extension HeaderTabView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
//MARK:UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        collectionView.deselectItem(at: indexPath, animated: true)
        
        self.dataSourcemodel = self.dataSourceCopy
        
        var model  = self.dataSourcemodel?[indexPath.row]
        
        model?.isSelectTed = true
        
      
        
      self.dataSourcemodel?[indexPath.row] = model!
        
        
        self.collectionView.reloadData()
        
        
    }
//MARK:UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.itemTitles.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    
        debugPrint("测试123123")
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderTabViewCollectionViewCell.cellId, for: indexPath) as! HeaderTabViewCollectionViewCell
        
        let model  = self.dataSourcemodel?[indexPath.row]
        
        
        cell.dataBind(model: model!)
        
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
   
  //MARK:UICollectionViewDelegateFlowLayout
    
//    //内编剧
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let top:CGFloat = 0;
//        
//        let bot:CGFloat = 0;
//        
//        let left:CGFloat = 0;
//        
//        let right:CGFloat = 0;
//        
//        
//        
//        return UIEdgeInsets.init(top: top, left: left, bottom: bot, right: right)
//        
//    }

}







