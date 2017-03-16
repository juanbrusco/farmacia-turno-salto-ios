//
//  ViewController.swift
//  FarmciasTurnoSalto
//
//  Created by Juan Ariel on 7/3/17.
//  Copyright © 2017 Juan Ariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var farmacia: Farmacia?;
    var alertController: UIAlertController?;
    
    @IBOutlet var btnLlamar: UIButton!
    @IBOutlet var btnMapa: UIButton!
    @IBOutlet var btnCompartir: UIButton!
    
    @IBAction func btnCompartir(_ sender: UIButton) {
    }
    
    @IBAction func btnMapa(_ sender: UIButton) {
    }
    
    @IBAction func btnLLamar(_ sender: UIButton) {
    }
    
    
    //labels
    @IBOutlet var lblNombreFarmacia: UILabel!
    @IBOutlet var lblHasta: UILabel!
    @IBOutlet var lblDireccion: UILabel!
    @IBOutlet var lblTelefono: UILabel!
    
    
    @IBAction func btnShare(_ sender: UIBarButtonItem) {
        let text = "https://itunes.apple.com/es/app/ifarmacias/id520847248?mt=8"
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //llama a un metodo al reabrir la app
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.appBecomeActive), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil );
        

        btnLlamar.setFAIcon(icon: .FAPhone, iconSize: 30, forState: .normal)
        btnLlamar.setFATitleColor(color: .white, forState: .normal)
        
        btnMapa.setFAIcon(icon: .FALocationArrow, iconSize: 30, forState: .normal)
        btnMapa.setFATitleColor(color: .white, forState: .normal)
        
        btnCompartir.setFAIcon(icon: .FAShareAlt, iconSize: 30, forState: .normal)
        btnCompartir.setFATitleColor(color: .white, forState: .normal)
        
        
        
        self.clearLabels();
        
        //desactivar touch mientras està el cargando
        view.isUserInteractionEnabled = false
        
        LoadingIndicatorView.show(self.view, loadingText: "Cargando");
        
        self.makeGetCall()

    }
    
    func clearLabels(){
        lblNombreFarmacia.text = "";
        lblHasta.text = "";
        lblDireccion.text = "";
        lblTelefono.text = "";
    }

    //mètodo llamado al reabrir la app
    func appBecomeActive() {
        
        //self.clearLabels();
        
        //desactivar touch mientras està el cargando
        view.isUserInteractionEnabled = false
        
        LoadingIndicatorView.show(self.view, loadingText: "Cargando");
        
        self.makeGetCall()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Obtener json de una URL
    func makeGetCall() {
        // indicar la URL para hacer el request
        let strUrl: String = "https://wuik.com.ar/services/farmacia-service_salto.php?token=16acd359cb1e6dced49963ac5dc350ccbccfab7e"
        guard let url = URL(string: strUrl) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            if error == nil {
                
                //Anything that updates the UI should run on the main thread, so all of your current handler code should be within a dispatch_async back onto the main queue.
                //It needs to be placed inside a different thread that allows the UI to update as soon as execution of thread function complete
                DispatchQueue.main.async {
                    // make sure we got data
                    guard let response = data else {
                        print("Error: did not receive data")
                        return
                    }
                    // parse the result as JSON, since that's what the API provides
                    do {
                        guard let parsedData = try JSONSerialization.jsonObject(with: response, options: []) as? [String: AnyObject]
                            else {
                                print("error trying to convert data to JSON")
                                return
                        }
                        // now we have the todo, let's just print it to prove we can access it
                        print("The todo is: " + parsedData.description)
                        
                        let arrJSON = parsedData["farmacias"];
                        let aObject = arrJSON![0] as AnyObject;
                        
                        self.farmacia = Farmacia(nombre:(aObject["nombre"] as! String),
                                                direccion:(aObject["direccion"] as! String),
                                                telefono:(aObject["telefono"] as! String),
                                                fechaDesde:(aObject["fechaDesde"] as! String),
                                                fechaHasta:(aObject["fechaHasta"] as! String));
                        
                        self.populateView();
                        
                        LoadingIndicatorView.hide();
                        
                        //reactivar touch
                        self.view.isUserInteractionEnabled = true
                        
                    } catch  {
                        print("error trying to convert data to JSON")
                        return
                    }

                }
            }else{
                print("error calling GET")
                
                /*LoadingIndicatorView.hide();
                self.view.isUserInteractionEnabled = true
                
                //alerta
                self.alertController = UIAlertController(title: "Error",
                                                                           message: "No hay conexión a internet",
                                                                           preferredStyle: .alert);
                //acciòn de alerta
                let accionController : UIAlertAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil);
                self.alertController?.addAction(accionController);
                //muestra alerta
                self.present(self.alertController!, animated: true, completion: nil);*/

                
                return
            }

        }
        
        task.resume()
    }
    
    func populateView(){
        //Formatear String a Objeto Date
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
        let dateObj = dateFormatter.date(from: (self.farmacia?.fechaHasta)!)
        
        //Formatear Date obtenido
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        print(dateFormatter.string(from: dateObj!))
        let dateFormat = dateFormatter.string(from: dateObj!);
        
        self.lblNombreFarmacia.text = self.farmacia?.nombre;
        self.lblHasta.text = "Hasta el \(dateFormat)hs.";
        self.lblDireccion.text = self.farmacia?.direccion;
        self.lblTelefono.text = self.farmacia?.telefono;

    }
    

}

