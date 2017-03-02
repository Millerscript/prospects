//
//  Prospectos.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import Foundation

class Prospecto{
    var nombre:String?
    var apellido:String?
    var cedula:String?
    var telefono:String?
    
    var estado:Int?
    
    init(_Nombre:String, _Apellido:String, _Cedula:String, _Telefono:String, _Estado:Int){
        self.nombre = _Nombre
        self.apellido = _Apellido
        self.cedula = _Cedula
        self.telefono = _Telefono
        self.estado = _Estado
    }
}
