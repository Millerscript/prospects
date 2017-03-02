//
//  EditarViewController.swift
//  TestApp
//
//  Created by Miller Mosquera on 25/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

class EditarViewController: UIViewController, UITextFieldDelegate {

    var nombreUsuario:String = ""
    var apellidoUsuario:String = ""
    var cedulaUsuario:String = ""
    var telefonoUsuario:String = ""
    var identificadorUsuario:Int = 0
    
    var tagEditar:Int = 0
    
    var estadoUsuario:Int = 0
    
    var pros:[Prospectos] = []
    
    let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var txtNombreUsuario: UITextField!
    
    @IBOutlet weak var txtApellidoUsuario: UITextField!
    
    @IBOutlet weak var lblDocumentoUsuario: UILabel!
    
    @IBOutlet weak var txtTelefonoUsuario: UITextField!
    
    @IBOutlet weak var seleccionarEstado: UISegmentedControl!
    
    
    let cProspectos = ControladorProspecto();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarProspectos()
        
        mostrarInformacion()
        
        asignarDelegados()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Guardar", style:.plain, target:self, action: #selector(guardarCambios))
        
    }
    
    func cargarProspectos() {
        
        do {
            pros = try _context.fetch(Prospectos.fetchRequest())
        } catch {
            print("Ha ocurrido un error al intentar cargar la información")
        }
        
    }
    
    func mostrarInformacion(){
        let data = pros[self.tagEditar]
        
        txtNombreUsuario.text = data.nombre
        txtApellidoUsuario.text = data.apellido
        lblDocumentoUsuario.text = data.cedula
        txtTelefonoUsuario.text = data.telefono
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func estados(_ sender: Any) {
        switch seleccionarEstado.selectedSegmentIndex
        {
        case 0:
            estadoUsuario = 0
            break;
            
        case 1:
            estadoUsuario = 1

            break;
        case 2:
            estadoUsuario = 2
            break;
            
        case 3:
            estadoUsuario = 3
            break;
        case 4:
            estadoUsuario = 4
            
            break;
        default:
            break; 
        }
    }
    
    func guardarCambios(){
        
        guard let __Nombre = txtNombreUsuario.text, !__Nombre.isEmpty else{
            
            let alerta = UIAlertController(title:"Error", message:"El campo Nombre es obligatorio", preferredStyle:UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
            self.present(alerta, animated: true, completion:nil)
            
            return
        }

        guard let __Apellido = txtNombreUsuario.text, !__Apellido.isEmpty else{
            
            let alerta = UIAlertController(title:"Error", message:"El campo Apellido es obligatorio", preferredStyle:UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
            self.present(alerta, animated: true, completion:nil)
            
            return
        }

        guard let __Telefono = txtNombreUsuario.text, !__Telefono.isEmpty else{
            
            let alerta = UIAlertController(title:"Error", message:"El campo Telefono es obligatorio", preferredStyle:UIAlertControllerStyle.alert)
            alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
            self.present(alerta, animated: true, completion:nil)
            
            return
        }
        
        
        let data = pros[self.tagEditar]
            
        let prospectoEditado = Prospecto(_Nombre:txtNombreUsuario.text!, _Apellido:txtApellidoUsuario.text!, _Cedula:lblDocumentoUsuario.text!, _Telefono:txtTelefonoUsuario.text!, _Estado:estadoUsuario);
            
        let success:Bool = cProspectos.editarProspectos(context: _context, data: data, datosActualizados: prospectoEditado)
            
        if success {
            let alerta = UIAlertController(title:"Mensaje", message:"Cambios realizados con éxito!", preferredStyle:UIAlertControllerStyle.alert)
                alerta.addAction(UIAlertAction(title:"Aceptar", style:UIAlertActionStyle.default, handler:nil))
            self.present(alerta, animated: true, completion:nil)
        }
        
    }
    
    func asignarDelegados(){
    
        self.txtNombreUsuario.delegate = self
        self.txtApellidoUsuario.delegate = self
        self.txtTelefonoUsuario.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let texto = txtTelefonoUsuario.text else { return true }
        
        let nuevoLimite = texto.characters.count + string.characters.count - range.length
        
        return nuevoLimite <= 10
        
    }
    
}
