//
//  ViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 25-05-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate  {

    
 

    @IBOutlet weak var textField: UITextField!
    
    var palabra: String?
    var toc : String = ""
    
    
    
    @IBOutlet weak var usuario: UITextField!
    
    @IBOutlet weak var clave: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usuario.delegate = self 
        clave.delegate = self
       usuario.returnKeyType = UIReturnKeyType.done
        clave.returnKeyType = UIReturnKeyType.done
        
        
        
        //post con el token 
      
        
        
        
       
    }
    
    func tokensiwi() {
        let paramater = ["username":usuario.text!, "password":clave.text!]
        
        
        var request = URLRequest(url: URL(string: "http://auth.aguasiot.cl/oauth/token?grant_type=password&username=\(usuario.text!)&password=\(clave.text!)")!)
        //print(request)
        //You can pass any required content types here
        request.httpMethod = "POST"
        // Some bad practice hard coding tokens in the Controller code instead of keychain.
        
        //You endpoint is setup as OAUTH 2.0 and we are sending Bearer token in Authorization header
        
        let loginData = String(format: "%@:%@", "aguas-iot", "shelke").data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
          request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: paramater, options: .prettyPrinted)
            
            
            
            
            
            
        }
            
            
        catch {
            print("json error: \(error)")
        }
        
        let session = URLSession.shared
        let task =  session.dataTask(with: request, completionHandler: { data , response , error in
            
            guard error == nil else {
                return
                
            }
            guard let data = data else {
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
                    
               let httpstatus = response as? HTTPURLResponse
                    
                    
                    
            
                    
                    
                if (httpstatus!.statusCode.description == "400") {
                    
                    

                    
                    let alert = UIAlertController(title: "Login", message: "Datos Incorrectos", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                   self.present(alert, animated: true, completion: nil)
                      
                    
                } else {
                
                self.toc = json.value(forKey: "access_token") as! String
                
                    self.performSegue(withIdentifier: "v", sender: self)

                    
                    
                    
                }
                
            
                })
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        })
        task.resume()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "v" {
        
         //  let claverecibida = sender as! String
            
           let objpantalla2:ViewController3 = segue.destination as! ViewController3
          
            objpantalla2.clavenviada = clave.text
            objpantalla2.usuarioenviado = usuario.text
            objpantalla2.token = self.toc
            
            
            
            
            
            
        }
    }
    
 
        
    
   @IBAction func boletadatos(_ sender: Any) {
        
 
   
   
        
    tokensiwi()

    
        /*
    var request = URLRequest(url: URL(string: "http://nami.herokuapp.com/bilo/api/v2.0/boleta/by-cliente/rut/\(usuario.text!)/by-id/\(clave.text!)")!)
    
    request.httpMethod = "GET"
    // Some bad practice hard coding tokens in the Controller code instead of keychain.
    

    
    
    //You endpoint is setup as OAUTH 2.0 and we are sending Bearer token in Authorization header
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue(self.toc, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    
    
    session.dataTask(with: request) {data, response, error in
        
        guard error == nil else {
            return
            
        }
        guard let data = data else {
            return
        }
        
        
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
          
                
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                
 
                
                // si el json devuelve en su primer valor "status" entonces hay un error y mando una alerta
                print(json.allValues[0])
                
                
                if (json.allKeys[0] as AnyObject).description == "status" {

                //alerta
                    let alert = UIAlertController(title: "Login", message: "Datos Incorrectos", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                
                } else {
                    
                    //si no manda error entonces lo envio hacia la otra pantalla siguiendo el segue "v" y le paso el dato clave.text
                    self.performSegue(withIdentifier: "v", sender: self)
                    
                    
                    
                }
                
            })
            
        
        }
        catch let error {
            let alert = UIAlertController(title: "Login", message: "Datos Incorrectos", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            print(error.localizedDescription)
        }
        }.resume()
    
    
    
    // nami.herokuapp.com/bilo/api/v1.0/boleta
    

   */
    
}

    
    
    
    
 
    @IBAction func buscar(_ sender: Any) {
        
        
        
    
        
        
 
    }
    
}
 

