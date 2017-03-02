//
//  crearCeldas.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import Foundation

import UIKit

class CrearCelda{
    
    private static let ESTADO_PENDIENTE = 0
    
    private static let ESTADO_APROVADO = 1
    
    private static let ESTADO_ACEPTADO = 2
    
    private static let ESTADO_RECHAZADO = 3
    
    private static let ESTADO_DESHABILITADO = 4
    
    private static let CELDA_PROSPECTOS = 1
    
    private static let CELDA_LOGS = 2
    
    let estilos = Estilos()
    
    func celda(controller:UIViewController, index:Int, data:Prospecto) -> UITableViewCell{
        
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: controller, options: nil)?.first as! TableViewCell
        
        cell.nombreUsuario.text = data.nombre! + " " + data.apellido!
        
        cell.cedulaUsuario.text = data.cedula
        
        cell.telefonoUsuario.text = data.telefono
        
        if data.estado == CrearCelda.ESTADO_PENDIENTE{
            cell.estadoUsuario.text = "Pendiente"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_PENDIENTE)
        }
        
        if data.estado == CrearCelda.ESTADO_APROVADO{
            cell.estadoUsuario.text = "Aprovado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_APROVADO)
        }
        
        if data.estado == CrearCelda.ESTADO_ACEPTADO{
            cell.estadoUsuario.text = "Aceptado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_ACEPTADO)
        }
        
        if data.estado == CrearCelda.ESTADO_RECHAZADO{
            cell.estadoUsuario.text = "Rechazado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_RECHAZADO)
        }
        
        if data.estado == CrearCelda.ESTADO_DESHABILITADO{
            cell.estadoUsuario.text = "Deshabilitado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_DESHABILITADO)
        }
        
        cell.editarUsuario.tag = index
        
        cell.editarUsuario.addTarget(controller, action: #selector(ViewController.Editar(_:)), for: UIControlEvents.touchUpInside)
        
        
        return cell
    }
    
    func celdaLog(controller:UIViewController, index:Int, data:Log) -> UITableViewCell{
        
        let cell = Bundle.main.loadNibNamed("LogViewCell", owner: controller, options: nil)?.first as! LogViewCell
        
        cell.nombre.text = data.nombre! + " " + data.apellidos!
        
        cell.documento.text = data.cedula
        
        cell.telefono.text = data.telefono
        
        cell.fechaEditado.text = data.fecha
        
        if data.estado == CrearCelda.ESTADO_PENDIENTE{
            cell.estado.text = "Pendiente"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_PENDIENTE)
        }
        
        if data.estado == CrearCelda.ESTADO_APROVADO{
            cell.estado.text = "Aprovado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_APROVADO)
        }
        
        if data.estado == CrearCelda.ESTADO_ACEPTADO{
            cell.estado.text = "Aceptado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_ACEPTADO)
        }
        
        if data.estado == CrearCelda.ESTADO_RECHAZADO{
            cell.estado.text = "Rechazado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_RECHAZADO)
        }
        
        if data.estado == CrearCelda.ESTADO_DESHABILITADO{
            cell.estado.text = "Deshabilitado"
            estilos.iconosEstados(icon: cell.iconEstado, estado: CrearCelda.ESTADO_DESHABILITADO)
        }
        
        return cell
    }
    
    
}
