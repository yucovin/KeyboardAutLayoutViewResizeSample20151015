//
//  ViewController.swift
//  KeyboardAutLayoutViewResizeSample20151015
//
//  Created by vincent nino on 2015/10/15.
//  Copyright © 2015年 yucovin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    //ConstraintのOutletで
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //スワイプでKeyboardをしまえる
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        //キーボードの出し入れをNotificationCenterからうけとる。UIKeyboardDidShowNotification、UIKeyboardDidHideNotificationもある。
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func keyboardWillShow(notification: NSNotification?) {
        
        guard let keyboardFrame = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(),
            duration:NSTimeInterval = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        bottomConstraint.constant = keyboardFrame.size.height + 10
        
        UIView.animateWithDuration(
            duration,
            animations: {
                self.view.layoutIfNeeded()
            },completion:nil)
    }
    
    func keyboardWillHide(notification: NSNotification?) {
        guard let duration = (notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double) else {
            return
        }
        
        bottomConstraint.constant = 10
        
        UIView.animateWithDuration(
            duration,
            animations:{
                self.view.layoutIfNeeded()
            },
            completion:nil)
    }
    
    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
//    

}

