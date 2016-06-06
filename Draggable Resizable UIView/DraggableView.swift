//
//  DraggableView.swift
//  Pre-Edits
//
//  Created by Richard Stockdale on 03/06/2016.
//  Copyright © 2016 Junction Seven. All rights reserved.
//

import Foundation
import UIKit

class DraggableView: UIView {
    
    let panGesture = UIPanGestureRecognizer()
    let pinchGesture = UIPinchGestureRecognizer()
    
    var firstX: CGFloat? // For panning
    var firstY: CGFloat? // For panning
    var lastScale: CGFloat? // For pinching
    
    override func awakeFromNib() {
        setUpGestureRecognisers()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpGestureRecognisers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpGestureRecognisers () {
        panGesture.addTarget(self, action: #selector(DraggableView.panGestureChanged))
        pinchGesture.addTarget(self, action: #selector(DraggableView.pinchGestureChanged))
        
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(pinchGesture)
    }
    
    func panGestureChanged () {
        
        // 1. Calculate and set the new location
        var locationInSuperView = panGesture.translationInView(self.superview) // Get the location of this view in the super view
        
        if panGesture.state == UIGestureRecognizerState.Began {
            firstX = self.center.x
            firstY = self.center.y

        }
        
        if firstX != nil && firstY != nil {
            locationInSuperView = CGPointMake(firstX!+locationInSuperView.x, firstY!+locationInSuperView.y)
            self.center = locationInSuperView // Set the new locationx
        }
        
        
    }
    
    func pinchGestureChanged () {
        if pinchGesture.state == UIGestureRecognizerState.Began {
            lastScale = 1.0
        }
        
        if lastScale != nil {
            let scale = 1.0 - (lastScale! - pinchGesture.scale)
            
            let newTransform: CGAffineTransform = CGAffineTransformScale(self.transform, scale, scale)
            
            // Only apply the changes if this view is shorter than the super view
            print(self.frame.size.height)
            
            if shouldViewSizeChange(self.frame.size.height) {
                self.transform = newTransform
                lastScale = pinchGesture.scale
            }
        }
    }
    
    func shouldViewSizeChange (height: CGFloat) -> Bool {
        let maxHeight: CGFloat = self.superview!.frame.size.height
        let minHeight: CGFloat = 140.0 // Any smaller than this and it's hard to pinch
        
        if height > minHeight && height < maxHeight {
            return true
        }
        else {
            if height > maxHeight && pinchGesture.scale < lastScale {
                return true;
            }
            if height < minHeight && pinchGesture.scale > lastScale {
                return true
            }
            
            return false
        }
    }
}