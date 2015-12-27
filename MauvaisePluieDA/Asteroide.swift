//
//  asteroide.swift
//  MauvaisePluieDA
//
//  Created by m2sar on 31/10/14.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import Foundation
import UIKit

class Asteroide{
    
    
    //private let ast = UIImageView(image:UIImage(named:"asteroide-100-01"));
    
    var id : Int
    
    var image : UIImageView
    
    var angle = CGFloat(0.0);
    var vitesser : CGFloat
    
    var dx : CGFloat
    var dy : CGFloat
    var vitesse : CGFloat
    
    var vitessex : CGFloat
    
    
    
    
    init(idp:Int ,name:String , dxp: CGFloat,dyp:CGFloat,vitess:CGFloat,vitessr:CGFloat, vitessx:CGFloat){
        id = idp
        image = UIImageView(image:UIImage(named:name))
        
        vitesser = vitessr
        image.center.x = dxp
        image.center.x = dyp
        dx = dxp
        dy = dyp
        vitesse = vitess
        vitessex = vitessx
        
    }
    
    
    
}