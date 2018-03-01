//
//  TestView.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/4/20.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

import UIKit

class TestView: UIView {
    
    
    //MARK:这是collecitonView的地方
    
    var dataSourcemodel:Array<HeaderTabViewCollectionViewCellModel>?
    
    var dataSourceCopy:Array<HeaderTabViewCollectionViewCellModel>?
    
    
    var flowLayout:UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        
        return layout
        
    }()
    
    
    var collectionView:UICollectionView!
    
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
    
    //MARK:这是collecitonView的地方
    
    
    //MARK:设置collectionview
    func addcollectionView()  {
        collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout)
        self.addSubview(self.collectionView)
        
        self.addcollectionViewP()
        
        self.collectionviewF()
        
    }
    
    func addcollectionViewP()  {
        collectionView.backgroundColor = UIColor.red
        
        collectionView.alwaysBounceHorizontal = true
        
        collectionView.collectionViewLayout = flowLayout
        
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"UICollectionViewCellId")
        
        
        
    }
    
    
    
    
    func collectionviewF()  {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    
    func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        self.addcollectionView()
        
//        let count  =  self.itemTitles.count - 1
        
        self.dataSourcemodel = Array()
        
        self.dataSourceCopy = Array()
        
        self.dataSourcemodel?.removeAll()
        self.dataSourceCopy?.removeAll()
        
//        for index in 0...count {
//            var model = HeaderTabViewCollectionViewCellModel.init(textStr: self.itemTitles[index], isSelectTed: false)
//            
//            self.dataSourceCopy?.append(model)
//            
//            if index == 0 {
//                model.isSelectTed = true
//            }
//            self.dataSourcemodel?.append(model)
//            
//            
//        }

        
    }

}



extension TestView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    //MARK:UICollectionViewDataSource
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        debugPrint("section这是")
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("numcell这是")
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        debugPrint("cell这是")
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCellId", for: indexPath)
        //        let model  = self.dataSourcemodel?[indexPath.row]
        //
        //
        //        cell.dataBind(model: model!)
        //
        cell.backgroundColor = UIColor.blue
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        debugPrint("didEndDisplaying")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        debugPrint("willDisplay")
    }
    
    //MARK:UICollectionViewDelegateFlowLayout
    //单元格大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = 50
        
        let h = 50
        
        return CGSize.init(width: w, height: h)
        
        
    }
    
    //内编剧
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top:CGFloat = 0;
        
        let bot:CGFloat = 0;
        
        let left:CGFloat = 0;
        
        let right:CGFloat = 0;
        
        
        
        
        return UIEdgeInsets.init(top: top, left: left, bottom: bot, right: right)
        
    }
    
    //纵向间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //横线间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    
 

}
