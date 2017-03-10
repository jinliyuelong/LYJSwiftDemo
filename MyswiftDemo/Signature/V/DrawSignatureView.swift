//
//  DrawSignatureView.swift
//  MyswiftDemo
//
//  Created by Liyanjun on 2017/2/7.
//  Copyright © 2017年 hand. All rights reserved.
//

import UIKit

public class DrawSignatureView: UIView {
    
    // 公共属性
    public var lineWidth: CGFloat = 2.0 {
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    public var strokeColor: UIColor = UIColor.black//画笔颜色
    public var signatureBackgroundColor: UIColor = UIColor.white//画板背景色
    
    // 私有属性
    // 绘制路径
    private var path = UIBezierPath()
    // 存储绘制时最新的5个点坐标
    private var pts = [CGPoint](repeating: CGPoint(), count: 5)
    // 索引，同上面的pts配合。每有5个点的话则绘制一段曲线，依次循环。整个签名图就是由一段段曲线组成的。
    private var ctr = 0
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
    
    // Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
    
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
    }
    
    
    
    
    
    
    // Draw
    override public func draw(_ rect: CGRect) {
        self.strokeColor.setStroke()//空心 
//        self.strokeColor.setFill()//实心
        self.path.stroke()//连线
    }
    
    // 触摸签名相关方法
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.location(in: self)
            self.ctr = 0
            self.pts[0] = touchPoint
        }
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.location(in: self)
            self.ctr += 1
            self.pts[self.ctr] = touchPoint
            if (self.ctr == 4) {
                
                self.pts[3] = CGPoint.init(x: (self.pts[2].x + self.pts[4].x)/2.0, y: (self.pts[2].y + self.pts[4].y)/2.0)
                self.path.move(to: self.pts[0])
                self.path.addCurve(to: self.pts[3], controlPoint1:self.pts[1],
                                   controlPoint2:self.pts[2])
                
                self.setNeedsDisplay()
                self.pts[0] = self.pts[3]
                self.pts[1] = self.pts[4]
                self.ctr = 1
            }
            
            self.setNeedsDisplay()
        }
    }
   
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.ctr == 0{
            let touchPoint = self.pts[0]
            self.path.move(to: CGPoint(x:touchPoint.x-1.0,y:touchPoint.y))
            self.path.addLine(to: CGPoint(x:touchPoint.x+1.0,y:touchPoint.y))
            self.setNeedsDisplay()
        } else {
            self.ctr = 0
        }
    }
    
  
    // 签名视图清空
    public func clearSignature() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    // 将签名保存为UIImage
    public func getSignature() ->UIImage {
        UIGraphicsBeginImageContext(CGSize(width:self.bounds.size.width,
                                           height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return signature
    }
}
