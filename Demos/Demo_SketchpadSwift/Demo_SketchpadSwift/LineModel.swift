//
//  LineModel.swift
//  Demo_SketchpadSwift
//
//  Created by SACRELEE on 16/2/2.
//  Copyright © 2016年 SACRELEE. All rights reserved.
//

import UIKit

class LineModel: NSObject {

    static var lineWidth:CGFloat = 5.0
    static var lineColor = UIColor.blackColor()
    static var linePoints = [CGPointMake( 0, 0)]
    
    var points: [CGPoint]
    var width: CGFloat
    var color: UIColor
    
    override init(){
         points = LineModel.linePoints
         points.removeAll()
         width = LineModel.lineWidth
         color = LineModel.lineColor
    }
}
