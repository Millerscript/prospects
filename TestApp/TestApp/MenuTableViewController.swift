//
//  MenuTableViewController.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var menu = ["Dashboard", "Lista de prospectos", "Cerrar sesión"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menu[indexPath.row]
        
        if item == "Cerrar sesión"{
            
            let destination: LoginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            
            UserDefaults.standard.setValue("0", forKey: "sesion")
            UserDefaults.standard.setValue(0, forKey: "identificadorUsuario")
            UserDefaults.standard.setValue("", forKey: "nombreUsuario")
            UserDefaults.standard.setValue("", forKey: "token")
            
            self.present(destination, animated: true, completion: nil)
        }
      
      
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)

        cell.textLabel?.text = menu[indexPath.row]

        return cell
    }

}
