//
//  ControladorLogs.swift
//  TestApp
//
//  Created by Miller Mosquera on 26/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import Foundation
import CoreData

class ControladorLogs{

    func guardarLog(objeto:Log, context:NSManagedObjectContext){
        
        let nuevoLog = NSEntityDescription.insertNewObject(forEntityName: "Logs", into: context)
        
        nuevoLog.setValue(objeto.nombre, forKey: "nombre")
        nuevoLog.setValue(objeto.apellidos, forKey: "apellidos")
        nuevoLog.setValue(objeto.cedula, forKey: "cedula")
        nuevoLog.setValue(objeto.telefono, forKey: "telefono")
        nuevoLog.setValue(objeto.estado, forKey: "estado")
        nuevoLog.setValue(objeto.fecha, forKey: "fecha")
        do{
            try context.save()
        }catch{
            print("No se pudieron guardar los datos locales")
        }
    }
    
}
