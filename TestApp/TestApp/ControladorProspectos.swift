//
//  ControladorProspectos.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import Foundation

import CoreData

class ControladorProspecto{
    
    func guardarProspecto(objeto:Prospecto, context:NSManagedObjectContext){
        
        let nuevoProspecto = NSEntityDescription.insertNewObject(forEntityName: "Prospectos", into: context)
        
        nuevoProspecto.setValue(1, forKey: "identificador")
        nuevoProspecto.setValue(objeto.nombre, forKey: "nombre")
        nuevoProspecto.setValue(objeto.apellido, forKey: "apellido")
        nuevoProspecto.setValue(objeto.cedula, forKey: "cedula")
        nuevoProspecto.setValue(objeto.telefono, forKey: "telefono")
        nuevoProspecto.setValue(objeto.estado, forKey: "estado")
        
        do{
            try context.save()
        }catch{
            print("No se pudieron guardar los datos locales")
        }
    }
    
    func obtenerProspectos(context:NSManagedObjectContext) -> NSMutableArray {
        
        let objectProspectos:NSMutableArray = NSMutableArray();
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Prospectos")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if( results.count > 0 ){
                
                for result in results as! [NSManagedObject]{
                    
                    objectProspectos.add(Prospecto(_Nombre:result.value(forKey: "nombre") as! String, _Apellido:result.value(forKey: "apellido") as! String, _Cedula:result.value(forKey: "cedula") as! String, _Telefono:result.value(forKey: "telefono") as! String, _Estado:result.value(forKey: "estado") as! Int));
                    
                    print( "\(result)" )
                    
                    if let nombre = result.value(forKey: "nombre") as? String{
                        
                        print( "Nombre de usuario: \(nombre)" )
                        
                        
                    }
                    
                }
                
            }
            
        } catch {
            
        }
        
        return objectProspectos
    }
    
    private func obtenerFecha()-> String{
        let fecha = Date()

        let dia = Calendar.current.component(.day, from: fecha)
        let mes = Calendar.current.component(.month, from: fecha)
        let anio = Calendar.current.component(.year, from: fecha)
        
        let fechaAct = String(dia) + "/" + String(mes) + "/" + String(anio)
        
        return fechaAct
    }
    
    func editarProspectos(context:NSManagedObjectContext, data:Prospectos, datosActualizados:Prospecto) -> Bool{

        let success:Bool?
        
        data.setValue(datosActualizados.nombre, forKey: "nombre")
        data.setValue(datosActualizados.apellido, forKey: "apellido")
        data.setValue(datosActualizados.telefono, forKey: "telefono")
        data.setValue(datosActualizados.estado, forKey: "estado")
        
        do{
            try context.save()
            success = true
            
            let cLogs = ControladorLogs()
            
            cLogs.guardarLog(objeto: Log(_Nombre:datosActualizados.nombre!, _Apellidos:datosActualizados.apellido!, _Cedula:datosActualizados.cedula!, _Telefono:datosActualizados.telefono!, _Estado:datosActualizados.estado!, _Fecha:obtenerFecha()), context: context)
            
            print("saved")
        }catch{
            print("could not save")
            success = false
        }
        
        return success!
    }
    

}
