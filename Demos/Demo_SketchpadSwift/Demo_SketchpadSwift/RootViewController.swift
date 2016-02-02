//
//  RootViewController.swift
//  Demo_SketchpadSwift
//
//  Created by SACRELEE on 16/2/2.
//  Copyright © 2016年 SACRELEE. All rights reserved.
//

import UIKit
import SnapKit

class RootViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paintingView = DrawingView()
        self.view.addSubview(paintingView)
        
        paintingView.snp_makeConstraints { (make) -> Void in
             make.edges.equalTo(self.view).inset( UIEdgeInsetsMake( 20, 0, 0, 0))
        }
        

        // Do any additional setup after loading the view.
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
