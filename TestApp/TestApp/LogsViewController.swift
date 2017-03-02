//
//  LogsViewController.swift
//  TestApp
//
//  Created by Miller Mosquera on 26/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

class LogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var logs:[Logs] = []
    
    let crearCelda = CrearCelda()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarLogs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func cargarLogs() {
        
        /*
         * refrescamos la lista de prospectos de manera local
         */
        do {
            self.logs = try self._context.fetch(Logs.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell();
        
        let log = logs[indexPath.row]
        
        cell = self.crearCelda.celdaLog(controller: self, index: indexPath.row, data: Log(_Nombre:log.nombre!, _Apellidos:log.apellidos!, _Cedula:log.cedula!, _Telefono:log.telefono!, _Estado:Int(log.estado), _Fecha:log.fecha!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }


}
