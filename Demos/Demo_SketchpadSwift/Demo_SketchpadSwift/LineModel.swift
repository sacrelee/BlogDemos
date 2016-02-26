//
//  LineModel.swift
//  Demo_SketchpadSwift
//
//  Created by SACRELEE on 16/2/2.
//  Copyright © 2016年 SACRELEE. All rights reserved.
//

import UIKit


class LineModel:NSObject{

    static var lineWidth:CGFloat = 5.0
    static var lineColorIndex = 1
    
    var points: [CGPoint] = [CGPoint]()
    var width: CGFloat
    var colorIndex: NSInteger
    
     override init(){
        points = []
        width = LineModel.lineWidth
        colorIndex = LineModel.lineColorIndex
    }
        
}

