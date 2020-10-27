//
//  Extensions.swift
//  Islamic
//
//  Created by Asliddin Rasulov on 20/10/20.
//

import Foundation
import UIKit

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        descriptionLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
    }

    override var frame: CGRect {
            get {
                return super.frame
            } set (newFrame) {
                textLabel?.numberOfLines = 0
                var frame = newFrame
                frame.origin.x += 10
                frame.size.width -= 20
                frame.origin.y += 5
                frame.size.height -= 10
                super.frame = frame
            }
        }
}

class EdgeInsetsLabel: UILabel {
    
    var textInsets =  UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                left: -textInsets.left,
                bottom: -textInsets.bottom,
                right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
}

extension UISearchBar {
    
    func changeSearchBarColor(color: UIColor) {
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 35)
        UIGraphicsBeginImageContext(frame.size)
        color.setFill()
        UIBezierPath(rect: frame).fill()
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.setSearchFieldBackgroundImage(makeRoundedImage(image: bgImage, radius: 15), for: .normal)
    }
    
    func makeRoundedImage(image: UIImage, radius: Float) -> UIImage {
        let imageLayer: CALayer = CALayer()
        imageLayer.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageLayer.contents = (image.cgImage as AnyObject)
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = 10
        UIGraphicsBeginImageContext(image.size)
        imageLayer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return roundedImage
    }
}
