//
//  Logs.swift
//  TestApp
//
//  Created by Miller Mosquera on 26/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import Foundation
class Log{
    var nombre:String?
    var apellidos:String?
    var cedula:String?
    var telefono:String?
    var fecha:String?
    var estado:Int?
    
    init(_Nombre:String, _Apellidos:String, _Cedula:String, _Telefono:String, _Estado:Int, _Fecha:String){
        self.nombre = _Nombre
        self.apellidos = _Apellidos
        self.cedula = _Cedula
        self.telefono = _Telefono
        self.estado = _Estado
        self.fecha = _Fecha
    }
}
