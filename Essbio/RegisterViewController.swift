//
//  RegisterViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 04-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var apellidoPaterno: UITextField!

    
    @IBOutlet weak var rut: UITextField!
    
    
    @IBOutlet weak var numeroServicio: UITextField!
    
    
    @IBOutlet weak var numeroServicio2: UITextField!
    
    
    @IBOutlet weak var nombre: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
   
        rut.delegate = self
        numeroServicio.delegate = self
        numeroServicio2.delegate = self
        
        
     
        
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
    
  
    
    
    func registro() {
        let paramater = ["username":rut.text!, "password":numeroServicio.text!]
        
        
        var request = URLRequest(url: URL(string: "http://auth.aguasiot.cl/user")!)
        //print(request)
        //You can pass any required content types here
        request.httpMethod = "POST"
        // Some bad practice hard coding tokens in the Controller code instead of keychain.
        
        //You endpoint is setup as OAUTH 2.0 and we are sending Bearer token in Authorization header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //  request.setValue(access_token, forHTTPHeaderField: "Authorization")
        
        
        
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
                    
                    
                    
                    
                    
                    
                    var status = httpstatus!.statusCode.description
                        
              print(status)
                    

                    switch status {
                    case "409":
                        
                        let alert = UIAlertController(title: "Register", message: "El usuario ya existe", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                   
                    case "404":
                        
                        let alert = UIAlertController(title: "Register", message: "Rut no registrado", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    case "201":
                        
                        let alert = UIAlertController(title: "Register", message: "Usuario registrado", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    default:
                        
                        let alert = UIAlertController(title: "Register", message: "Estamos en mantencion!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                        
                        
                        
                
                    
                    
                })
                
                
            } catch let error {
                print(error.localizedDescription)
            
                
                
            }
            
            
        })
        task.resume()
    }


    @IBAction func register(_ sender: UIButton) {
        if (numeroServicio.text! == numeroServicio2.text!) {
        
            registro()
            
        }
        
        else {
        
            let alert = UIAlertController(title: "Register", message: "Las contraseñas no coinciden", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }

}
