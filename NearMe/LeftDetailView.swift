//
//  LeftDetailView.swift
//  NearMe
//
//  Created by Mac Bellingrath on 10/5/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import MapKit

public class LeftDetailView:  MKAnnotationView {

    @IBInspectable var imageView: UIImageView = UIImageView()
   
    override public func drawRect(rect: CGRect) {
        // Drawing code
        
        imageView = UIImageView(frame: rect)
        imageView.image = UIImage(named: "swift")
        self.addSubview(imageView)
        
        
    }

}
