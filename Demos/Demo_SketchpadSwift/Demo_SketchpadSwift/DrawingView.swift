//
//  DrawingView.swift
//  Demo_SketchpadSwift
//
//  Created by SACRELEE on 16/2/2.
//  Copyright © 2016年 SACRELEE. All rights reserved.
//

import UIKit
import SnapKit


class DrawingView: UIView {
    
    var lineModels = [LineModel]()
    var willDraw:() -> Void = {_ in }
    let fm = FMDBManager.defaultManager
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        let panGr = UIPanGestureRecognizer.init(target: self, action: "panInView:")
        self.addGestureRecognizer(panGr)
    }
    
    func canSaveData() -> Bool{
        if self.lineModels.count == 0 {
           return false
        }

           return true
    }
    
    func saveData() -> Bool{
        if fm.saveLineModels(lineModels: self.lineModels) {
           print("data saved!")
           return true
        }
        print("data save error!")
        return false
    }
    
    func readData(){
        
        if let tmpModels = fm.getLineModelArray() {
            if tmpModels.count != 0 {
             self.lineModels = tmpModels
             self.setNeedsLayout()
             print("data read!")
                return
            }
            print("null data!")
            return
        }
        
        print("read data error!")
    }
    
    func clearData(){
        lineModels.removeAll()
        self.setNeedsDisplay()
    }
    
    func panInView( pan:UIPanGestureRecognizer){
      
        if pan.state == .Began{
           self.willDraw()
           lineModels.append(LineModel.init())
        }
        
        let lastLM = lineModels.last!
        lastLM.points.append(pan.locationInView(self))
        
        if pan.state == .Ended{
          print("\(lastLM.points)")
        }
        self.setNeedsDisplay()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
          let contextRef = UIGraphicsGetCurrentContext()
          CGContextScaleCTM( contextRef, 1, 1)
        
        for line in lineModels {
        
           ConfigManager.colorArray[line.colorIndex].set()
            CGContextSetLineWidth( contextRef, line.width)
            
            let firstPoint = line.points[0]
            CGContextBeginPath( contextRef)
            CGContextMoveToPoint( contextRef, firstPoint.x, firstPoint.y)
            
            var lastPoint = firstPoint
            for var i = 0; i < line.points.count; i++ {
               let currentPoint = line.points[i]
               
                 CGContextAddQuadCurveToPoint( contextRef, lastPoint.x, lastPoint.y, ( currentPoint.x + lastPoint.x) / 2.0, ( currentPoint.y + lastPoint.y ) / 2.0)
               
               lastPoint = currentPoint
            }
            
            CGContextAddLineToPoint( contextRef, lastPoint.x, lastPoint.y)
            CGContextStrokePath( contextRef)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
