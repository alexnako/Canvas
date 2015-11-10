//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Alex Nako on 11/9/15.
//  Copyright © 2015 Alex Nako. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGFloat!
    var trayUp: CGFloat!
    var trayDown: CGFloat!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceInitialCenter: CGPoint!
    @IBOutlet weak var arrowView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayUp = 508
        trayDown = 678
        trayOriginalCenter = trayUp
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    @IBAction func onTrayPan(sender: UIPanGestureRecognizer) {
        print("yes")
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if trayView.center.y > 480 {
            trayView.center.y = trayOriginalCenter + translation.y
        }
        
        
        
        if sender.state == UIGestureRecognizerState.Began {
            print(trayOriginalCenter)
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.y < 0 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.trayView.center.y = self.trayUp
                    self.arrowView.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
                })
                
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.trayView.center.y = self.trayDown
                    self.arrowView.transform = CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))
                })
                
            }
            self.trayOriginalCenter = trayView.center.y
        }
    }

    
   @IBAction func onHappyPan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            // CREATING AND ADJUSTING IMAGE
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceInitialCenter = newlyCreatedFace.center
            
            //ADDING GESTURE TO NEW IMAGE
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "OnCustomPan:")
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            self.newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceInitialCenter.x + translation.x, y: newlyCreatedFaceInitialCenter.y + translation.y)
        }
    }
    
    
    func OnCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        let face = panGestureRecognizer.view
        let location = panGestureRecognizer.locationInView(view)

        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                face!.transform = CGAffineTransformMakeScale(1.3, 1.3)
            })
        }
        if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            face!.center = location
        }
        if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                face!.transform = CGAffineTransformMakeScale(1, 1)
            })
            
        }
    }
    
}
