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
    
    init() {
        super.init(frame: CGRectZero)
        self.backgroundColor = UIColor.whiteColor()
        let panGr = UIPanGestureRecognizer.init(target: self, action: "panInView:")
        self.addGestureRecognizer(panGr)
    }
    
    func panInView( pan:UIPanGestureRecognizer){
      

        if pan.state == .Began{
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
        
            line.color.set()
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
