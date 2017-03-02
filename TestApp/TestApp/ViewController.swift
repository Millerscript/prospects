//
//  ViewController.swift
//  TestApp
//
//  Created by Miller Mosquera on 24/02/17.
//  Copyright © 2017 Mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var botonMenu: UIBarButtonItem!

    @IBOutlet weak var loadingLista: UIView!
    
    @IBOutlet weak var indicadorLoading: UIActivityIndicatorView!
    
    let _context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var arProspectos:[Prospectos] = []
    
    let crearCelda = CrearCelda()
    
    let cProspectos = ControladorProspecto();
    
    @IBOutlet weak var listaProspectos: UITableView!
    
    var nombre:String = ""
    var apellido:String = ""
    var documento:String = ""
    var telefono:String = ""
    var identificador:Int = 0
    var estado:Int = 0
    var tag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        /*
         * accion del menu 'reveal'
         */
        if revealViewController() != nil{
            botonMenu.target = revealViewController()
            botonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
    }

    func mostrarIndicador(){
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingLista.frame = CGRect(origin: CGPoint(x: 0,y :463), size: CGSize(width: 321, height: 41))
            self.indicadorLoading.startAnimating()
        })
        
    }
    
    func ocultarIndicador(){
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingLista.frame = CGRect(origin: CGPoint(x: 0,y :510), size: CGSize(width: 321, height: 41))
            self.indicadorLoading.stopAnimating()
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        mostrarIndicador()
      
      
        /*
         * carga la información
         */
        self.cargarListaProspectos()
        
        /*
         * refrescamos la lista de prospectos de manera local
         */
        refrescarLista()
        
    }
    
    
    func cargarListaProspectos() {
        
        /*
         * Traemos la lista de prospectos del servidor
         */
        var request = URLRequest(url: URL(string: Config.APP_URL + Config.REST_PROSPECTOS)!)
        request.httpMethod = "GET"
        
        let postString = ""
        request.httpBody = postString.data(using: .utf8)
      
        /* Header de la petición */
        request.addValue(UserDefaults.standard.value(forKey: "token") as! String, forHTTPHeaderField: "token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
              
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // errores http
            }
            

            self.ocultarIndicador()
          
            /*
             * Guardamos la informacion de los prospectos de forma local.
             */
            self.guardarListaLocal(data: data)

        }
      
        task.resume()
        
    }
  
  
    /*
     * Refresca la la lista de datos y la vista de la tabla
     */
    func refrescarLista(){
    
            do {
                self.arProspectos = try self._context.fetch(Prospectos.fetchRequest())
                self.listaProspectos.reloadData()
            } catch {
                print("Fetching Failed")
            }
      
    }
  
  
  
    /*
     * Guarda la información traida desde el servidor de manera local.
     */
    private func guardarListaLocal(data:Data){
      
        /*
         * Verifica las veces que el usuario ha accedido a la app para guardar una sola vez la información de los prospectos
         */
        if UserDefaults.standard.value(forKey: "access") as! Int == 1{
            
            UserDefaults.standard.setValue(2, forKey: "access")
          
            DispatchQueue.main.async {
              
                let result = JSON(data:data)
                
                for(_, subJson):(String, JSON) in result["data"]["prospects"]{
                    
                    print(subJson["name"])
                    
                    self.cProspectos.guardarProspecto(objeto: Prospecto(_Nombre:subJson["name"].stringValue, _Apellido:subJson["lastName"].stringValue, _Cedula:subJson["cardID"].stringValue, _Telefono:subJson["phone"].stringValue, _Estado:subJson["status"].intValue), context: self._context);
                    
                }
              
              self.refrescarLista()
              
            }
            
        }else{
          self.refrescarLista()
        }
      
    }
  
  
    /*
     * Abre el formulario con la informacion del prospecto a editar
     */
    func Editar(_ Sender:UIButton){

        self.tag = Sender.tag
        
        self.performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arProspectos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell();
        
        let prospecto = arProspectos[indexPath.row]

        cell = self.crearCelda.celda(controller: self, index: indexPath.row, data: Prospecto(_Nombre:prospecto.nombre!, _Apellido:prospecto.apellido!, _Cedula:prospecto.cedula!, _Telefono:prospecto.telefono!, _Estado:Int(prospecto.estado)))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            let sEditar:EditarViewController = segue.destination as! EditarViewController

            sEditar.tagEditar = self.tag
          
        }
    }

}

