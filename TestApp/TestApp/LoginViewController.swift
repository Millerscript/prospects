//
//  LoginViewController.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    
    let estilos = Estilos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.verificarSesion()
        self.establecerEstilos()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        
        if self.correo.text?.isEmpty == false || self.contrasena.text?.isEmpty == false{
            
            if validarCorreo(correo: self.correo.text!) == true{
            
                var request = URLRequest(url: URL(string: Config.APP_URL + Config.REST_LOGIN)!)
                request.httpMethod = "GET"
                let postString = ""
                request.httpBody = postString.data(using: .utf8)
            
                request.addValue(self.correo.text!, forHTTPHeaderField: "email")
                request.addValue(self.contrasena.text!, forHTTPHeaderField: "password")
            
                
                /*
                 * El servicio no retorna error en caso de estar errado el usuario y la contrasena
                 */
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                      
                      let alerta = UIAlertController(title:"Error", message:"No tienes acceso a internet.", preferredStyle:UIAlertControllerStyle.alert)
                      
                      alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
                      
                      self.present(alerta, animated: true, completion:nil)
   
                      return
                    }
                
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                      // errores http

                    }

                    DispatchQueue.main.async {
                        let result = JSON(data:data)
                    
                        if( result["status"] == 200 ){
                        
                            UserDefaults.standard.setValue("1", forKey: "sesion")
                            UserDefaults.standard.setValue(result["data"]["userId"].intValue, forKey: "identificadorUsuario")
                            UserDefaults.standard.setValue(result["data"]["fullname"].stringValue, forKey: "nombreUsuario")
                            UserDefaults.standard.setValue(result["data"]["token"].stringValue, forKey: "token")
                            UserDefaults.standard.setValue(1, forKey: "access")
                        
                            self.performSegue(withIdentifier: "master", sender: self)
                        
                        }
                    }

                }
                
                task.resume()
                
            }else{
                
                let alerta = UIAlertController(title:"Error", message:"El correo electrónico es incorrecto", preferredStyle:UIAlertControllerStyle.alert)
                alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
                self.present(alerta, animated: true, completion:nil)
                
            }
            
        }else{
        
            let alerta = UIAlertController(title:"Error", message:"Debes ingresar el correo y la contraseña", preferredStyle:UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
            self.present(alerta, animated: true, completion:nil)
            
        }
        
    }

    func validarCorreo(correo:String) -> Bool{
        
        let regExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let correoComp = NSPredicate(format:"SELF MATCHES %@", regExp)
        
        return correoComp.evaluate(with: correo);
    }
    

    func establecerEstilos(){
        estilos.inputRounded(input: self.correo)
        estilos.inputRounded(input: self.contrasena)
    }
    
    func verificarSesion(){
        if UserDefaults.standard.value(forKey: "sesion") != nil {
            print("User sesion exist\(UserDefaults.standard.value(forKey: "sesion")!)")
            if UserDefaults.standard.value(forKey: "sesion") as! String == "1"{
                UserDefaults.standard.setValue(2, forKey: "access")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "master", sender: self)
                }
                
            }
        }
    }
 
}
