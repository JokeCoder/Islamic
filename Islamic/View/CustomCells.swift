//
//  CustomCells.swift
//  Islamic
//
//  Created by Asliddin Rasulov on 27/10/20.
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

class CustomCollectionCell: UICollectionViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}

class CalendarCustomCell: UICollectionViewCell {
    @IBOutlet weak var numLabel: UILabel!
}
