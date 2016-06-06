//
//  ViewController.swift
//  Draggable Resizable UIView
//
//  Created by Richard Stockdale on 06/06/2016.
//  Copyright © 2016 Junction Seven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = CGRectMake(50, 50, 200, 200) // Temp

        let draggableView = DraggableView(frame: frame)
        draggableView.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(draggableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

