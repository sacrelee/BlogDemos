//
//  RootViewController.swift
//  Demo_SketchpadSwift
//
//  Created by SACRELEE on 16/2/2.
//  Copyright © 2016年 SACRELEE. All rights reserved.
//

import UIKit
import SnapKit


let svHeight = 200.0

class RootViewController: UIViewController {
    
    let settingView = UIView()
    var lastLineColorIndex = 0
    var eraserWidth: CGFloat?
    var lineWidth: CGFloat?
    var showSettingView = false
    let paintingView = DrawingView()
    let colorArray = ConfigManager.colorArray
    
    override func viewWillAppear(animated: Bool) {
        paintingView.readData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        paintingView.saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.clipsToBounds = false
        
        //  DrawingView
        paintingView.willDraw = { self.displaySettings(false) }
        self.view.addSubview(paintingView)
        paintingView.snp_makeConstraints { (make) -> Void in
             make.edges.equalTo(self.view).inset( UIEdgeInsetsMake( 20, 0, 0, 0))
        }

        // function buttons
        for i in 0...2{
            let settingBtn = UIButton()
            self.view.addSubview(settingBtn)
            
            settingBtn.tag = i + 10
            settingBtn.setTitle( i == 0 ? "设置": i == 1 ? "保存": "清空", forState: .Normal)
            settingBtn.setTitleColor( UIColor.blackColor(), forState: .Normal)
            settingBtn.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
            settingBtn.snp_makeConstraints { (make) -> Void in
                make.size.equalTo( CGSizeMake( 100, 50))
                make.bottom.equalTo( -10)
                make.left.equalTo(i == 0 ? 0: i == 1 ? 100: 200)
            }
        }
        
        // function View
        self.view.addSubview(settingView)
        settingView.backgroundColor = UIColor.whiteColor()
        settingView.snp_makeConstraints { (make) -> Void in
            make.height.equalTo( svHeight)
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view.snp_bottom).offset(svHeight)
        }
        settingView.layoutIfNeeded()
        let settingLine = CALayer()
        settingLine.backgroundColor = UIColor(red:0.14, green:0.6, blue:0.93, alpha:1).CGColor
        settingLine.frame = CGRectMake( 0, 0, settingView.frame.width, 0.5)
        settingView.layer.addSublayer(settingLine)
        
        for i in 0...1{
           let label = UILabel()
           label.text = i == 0 ? "橡皮擦": "线型"
           label.textAlignment = .Center
           label.textColor = UIColor(red:0.14, green:0.6, blue:0.93, alpha:1)
           settingView.addSubview(label)
           label.tag = 20 + i
           label.snp_makeConstraints(closure: { (make) -> Void in
              make.size.equalTo( CGSizeMake( 80, 50))
              make.left.equalTo( settingView)
            if i == 0{
               make.top.equalTo( settingView).offset( 25)
            }
            else{
               make.bottom.equalTo( settingView).offset( -25)
            }
           })
        }
        
        let topLabel = self.view.viewWithTag(20)!
        let eraserSwitch = UISwitch()
        eraserSwitch.addTarget(self, action: "switchValueChanged:", forControlEvents:.ValueChanged)
        eraserSwitch.tag = 30
        settingView.addSubview(eraserSwitch)
        eraserSwitch.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topLabel).offset(10)
            make.left.equalTo( topLabel.snp_right).offset(5)
        }
        
        eraserWidth = CGFloat(15.0)
        lineWidth = CGFloat(3.0)
        for i in 0...1 {
            let slider = UISlider()
            settingView.addSubview(slider)
            slider.tag = 40 + i
            slider.enabled = i == 0 ? false: true
            slider.value = i == 0 ? Float(eraserWidth!): Float(lineWidth!)
            slider.minimumValue = i == 0 ? 10.0: 1.0
            slider.maximumValue = i == 0 ? 20.0: 6.0
            slider.addTarget( self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
            slider.snp_makeConstraints { (make) -> Void in
                make.top.equalTo( i == 0 ? eraserSwitch: self.view.viewWithTag(21)!).offset( i == 0 ? 0: -25)
                make.left.equalTo( i == 0 ? eraserSwitch.snp_right: topLabel.snp_right).offset( i == 0 ? 20: 5)
                make.right.equalTo(settingView).offset(-20)
            }
        }

        let lineSlider = self.view.viewWithTag(41)!
        lineSlider.layoutIfNeeded()
        let gap = ( lineSlider.frame.size.width - 35 * 5 ) / 4.0
       
        // color buttons
        for i in 1...5{
           let colorButton = UIButton()
           settingView.addSubview(colorButton)
           colorButton.tag = 50 + i
           colorButton.backgroundColor = colorArray[i]
           colorButton.layer.borderWidth = 1.0
            colorButton.layer.borderColor = i == 1 ? UIColor.grayColor().CGColor: UIColor.clearColor().CGColor
           colorButton.layer.masksToBounds = true
           colorButton.layer.cornerRadius = 7.0
           colorButton.addTarget(self, action: "colorButtonClick:", forControlEvents: .TouchUpInside)
           colorButton.snp_makeConstraints(closure: { (make) -> Void in
              make.size.equalTo(CGSizeMake( 35, 35))
              make.top.equalTo(lineSlider.snp_bottom).offset(20)
              make.left.equalTo( i == 1 ? lineSlider.snp_left: self.view.viewWithTag(50 + i - 1)!.snp_right).offset( i == 1 ? 0: gap)
           })
        }
        
        let cancelButton = UIButton()
        settingView.addSubview(cancelButton)
        cancelButton.tag = 60
        cancelButton.setTitle("取消", forState:.Normal)
        cancelButton.setTitleColor(UIColor(red:0.14, green:0.6, blue:0.93, alpha:1), forState: .Normal)
        cancelButton.addTarget(self, action:"buttonClick:", forControlEvents:.TouchUpInside)
        cancelButton.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake( 80, 50))
            make.top.equalTo(topLabel).offset(-30)
            make.right.equalTo(settingView)
        }
        
        // Do any additional setup after loading the view.
    }
    
    //
    func switchValueChanged( sender: UISwitch){
    
        (self.view.viewWithTag(40) as! UISlider).enabled = sender.on
        (self.view.viewWithTag(41) as! UISlider).enabled = !sender.on
        
        if sender.on == false{
           LineModel.lineColorIndex = lastLineColorIndex
           LineModel.lineWidth = lineWidth!
        }
        else{
           lastLineColorIndex = LineModel.lineColorIndex
           LineModel.lineColorIndex = 0
           LineModel.lineWidth = eraserWidth!
        }
        
        print("\(sender.on)")
    }
    
    //
    func sliderValueChanged( sender: UISlider){
        LineModel.lineWidth = CGFloat.init( sender.value)
        if sender.tag % 10 == 0 {
           eraserWidth = CGFloat.init( sender.value)
        }
        else{
           lineWidth = CGFloat.init( sender.value)
        }
       
        print("\( sender.value)")
    }
    
    //
    func colorButtonClick( sender: UIButton){
        
        let es = self.view.viewWithTag(30) as! UISwitch
        if es.on == true {
          return
        }
        
        for i in 1...5{
            self.view.viewWithTag(i + 50)!.layer.borderColor = i + 50 == sender.tag ? UIColor.grayColor().CGColor: UIColor.clearColor().CGColor
        }
        
        let index = sender.tag % 10
        LineModel.lineColorIndex = index
        es.on = false
    }
    
    //
    func buttonClick( btn:UIButton){
        print("\(btn.tag)")
        
        // settings
        if btn.tag == 10 {
            self.displaySettings(true)
        }
        else if btn.tag == 11{   // save

            if paintingView.canSaveData() == false {
               return
            }
            
            let content:String
            if paintingView.saveData() == true {
                content = "保存成功！"
            }
            else {
                content = "保存失败！"
            }
            let uac = UIAlertController(title: "提示", message: content, preferredStyle: .Alert)
            uac.addAction(UIAlertAction(title: "确定", style:.Default, handler: { (ac) -> Void in
            }))
            
            self.presentViewController( uac, animated:true) { () -> Void in
            }
        }
        else if btn.tag == 12{   // clear
            paintingView.clearData()
        }
        else {    // cancel
            self.displaySettings(false)
        }
    }
    
    //
    func displaySettings( display:Bool){
        
        self.view.setNeedsUpdateConstraints()
        UIView.animateWithDuration( 0.5) { () -> Void in
           
            self.settingView.snp_updateConstraints { (make) -> Void in
                make.height.equalTo( svHeight)
                make.width.equalTo(self.view)
                if display == true {
                    make.bottom.equalTo( self.view)
                }
                else{
                    make.bottom.equalTo( self.view).offset( svHeight)
                }
            }
            
          self.view.layoutIfNeeded()
          self.settingView.layoutIfNeeded()
        }
  
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
