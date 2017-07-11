//
//  FiltrarViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 02-07-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class FiltrarViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var deudactual: UILabel!
    var token: String?
    var idd : Int?
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var numboleta: UILabel!
    @IBOutlet weak var numservicio: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id.delegate = self
        
    print(token!)
    }
    

    // ocultar teclado al hacer click en return y mover los textfield para q el teclado no los tape
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -75, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -75, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    @IBAction func filtrar(_ sender: Any) {
        
        var request = URLRequest(url: URL(string: "http://api.aguasiot.cl/boletas/by-id/\(id.text!)")!)
        
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
                    
                    
                    //   let  bol : String? = json.value(forKey: "fechaVencimiento") as? String
                    
                    // self.boleta.text = bol
                    
                    
                    
                    let dact: Int? = json.value(forKey: "total") as! Int
                    self.deudactual.text = dact!.description
                    
                    let  num: Int? = json.value(forKey: "id") as! Int
                    self.numboleta.text = num!.description
                    
                    let  num2: Int? = json.value(forKey: "numero_servicio") as! Int
                    self.numservicio.text = num2!.description
                    
                    // let serv: Int? = json.value(forKey: "servicio") as! Int
                    // self.servicio.text = serv!.description
                    
                    
                }
                
                
            }
            catch let error {
                print(error.localizedDescription)
            }
            }.resume()
    }
      

}
