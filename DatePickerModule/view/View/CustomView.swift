//
//  CustomView.swift
//  ICRM-Customer
//
//  Created by Amir on 5/4/17.
//  Copyright © 2017 Amir. All rights reserved.
//

import UIKit

class CustomView: UIView ,Shadowable,Dashable{
    
    var dashLayer: CAShapeLayer?
    
    
    var tempOffset = CGSize()
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var hasShadow: Bool = false {
        didSet {
            self.config()
        }
    }
    
    @IBInspectable var borderColor: UIColor! = UIColor.clear {
        didSet {
            config()
        }
    }
    
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            config()
        }
    }
    
    var tap : (()->Void)?{
        didSet{
            initaili()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let dash = self.dashLayer {
            self.layer.addSublayer(dash)
        }
        
    }
    
    func config() {
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.setCorner(radius: self.radius)
        if hasShadow {
            self.dropShadow()
        }
    }
    
    func initaili(){
        if let _ = self.tap {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickOn))
            self.addGestureRecognizer(tap)
        }
    }
    @objc func clickOn(){
        if let clicki = self.tap {
            clicki()
        }
    }
    
    func setCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
    }
    
    fileprivate func touchUp() {}
    
    
}


extension CustomView {
    
    func cirularView(fromWidth width :Bool = true)-> CustomView {
        if width{
         self.layer.cornerRadius = self.frame.width / 2
        }else{self.layer.cornerRadius = self.frame.height / 2}
        
        return self
        
    }
    
    func setSpecificCorner(corner : UIRectCorner , w : CGFloat , h : CGFloat){
        
        let maskPath = UIBezierPath(roundedRect: self.frame,
         byRoundingCorners: corner,
         cornerRadii: CGSize(width:w, height:h))
         
         let shape = CAShapeLayer()
         shape.path = maskPath.cgPath
         self.layer.mask = shape
        
        
    }
    

    
    func setShadow(withOffset offset : CGSize =  CGSize(width: 0, height: -2),
                   byColor color : UIColor = UIColor.black , upSize up : Bool = true)->CustomView {
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        
        
        return self
        
    }
    
    func firstChildAs<T>()->T?{
        return self.subviews.first as? T
    }
}
