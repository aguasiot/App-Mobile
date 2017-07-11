//
//  ViewController3.swift
//  Essbio
//
//  Created by Matias Villagran on 02-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    @IBAction func filtrar(_ sender: Any) {
     //   self.performSegue(withIdentifier: "s", sender: self)

    }
    @IBOutlet weak var bigdeuda: UILabel!
    @IBOutlet weak var servicio: UILabel!
    @IBOutlet weak var deudaanterior: UILabel!
    @IBOutlet weak var deudactual: UILabel!
    @IBOutlet weak var boleta: UILabel!
    var clavenviada: String?
    var usuarioenviado: String?
    var token: String?
    
    //al hacer click en el boton lo envio a una url externa en safgari
  
    @IBAction func pagar(_ sender: UIButton)
    
    {
        
    if let url = NSURL(string: "http://www.essbio.cl/hogar/hogar_paga_tu_cuenta.php"){
      
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
       
        }
    }
 
    //al hacer click en el boton lo envio a una url externa en safgari

    @IBAction func pagar2(_ sender: UIButton) {
        
        if let url = NSURL(string: "http://www.essbio.cl/hogar/hogar_paga_tu_cuenta.php"){
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
        }

    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(usuarioenviado!)
       print(clavenviada!)
        print(token!)
        var request = URLRequest(url: URL(string: "http://api.aguasiot.cl/boletas/last")!)
       
        request.httpMethod = "GET"
        // Some bad practice hard coding tokens in the Controller code instead of keychain.
        let access_token = token!
        //You endpoint is setup as OAUTH 2.0 and we are sending Bearer token in Authorization header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, error in
            
            guard error == nil else {
                return
                
            }
            guard let data = data else {
                return
            }
            
            print(data)
            
            
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
                
                DispatchQueue.main.async {
                /* 
                     //alerta
                     let alert = UIAlertController(title: "Login", message: "Datos Incorrectos", preferredStyle: UIAlertControllerStyle.alert)
                     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                     
                     self.present(alert, animated: true, completion: nil)
                     */
                    
                 
              
                
                    
                    
                    
        
                    
                    print(json)
                    
               
                let  bol : String? = json.value(forKey: "fechaVencimiento") as? String
                    
                self.boleta.text = bol
                    
                let dact: Int? = json.value(forKey: "total") as! Int
                self.deudactual.text = dact!.description
                let dant: Int? = json.value(forKey: "subTotal") as! Int
                self.deudaanterior.text = dant!.description
               // let serv: Int? = json.value(forKey: "servicio") as! Int
               // self.servicio.text = serv!.description
                self.bigdeuda.text = "$ \(dact!.description)"
                    
                    
                    }
                
                
            }
            catch let error {
                print(error.localizedDescription)
            }
            }.resume()
        
        
        
        // nami.herokuapp.com/bilo/api/v1.0/boleta
        
        
        
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "s" {
          let objpantalla1:FiltrarViewController = segue.destination as! FiltrarViewController
        objpantalla1.token = token
        
        }
        
        if segue.identifier == "i" {
            let objpantallax:imagenViewController = segue.destination as! imagenViewController
            objpantallax.token = token
            
        }
        
        if segue.identifier == "a" {
            let objpantalla5:ReportViewController = segue.destination as! ReportViewController
            objpantalla5.token = token
            
        }
    }


}
