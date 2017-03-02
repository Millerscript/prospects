//
//  Estilos.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import Foundation
import UIKit

class Estilos{

    func inputRounded(input:UITextField){
        input.layer.cornerRadius = 12;
    }
    
    func iconosEstados(icon:UIImageView, estado:Int){
        
        switch estado {
        case 0:
            icon.image = UIImage(named:"pending")
            break;
        case 1:
            icon.image = UIImage(named:"approved")
            break;
        case 2:
            icon.image = UIImage(named:"accepted")
            break;
        case 3:
            icon.image = UIImage(named:"rejected")
            break;
        case 4:
            icon.image = UIImage(named:"disabled")
            break;
        default:
            break;
        }
        
        
        
    }
    
}
