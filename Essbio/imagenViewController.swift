//
//  imagenViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 14-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class imagenViewController: UIViewController {
    
    var ima = ""
    
    var token : String?
    
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var ciudad: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(token!)
        
        var request = URLRequest(url: URL(string: "http://api.aguasiot.cl/casas/by-id/4")!)
        
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
                    
                    
                    let  bol : String? = json.value(forKey: "region") as? String
                    
                    self.region.text = bol
                    
                    let  ciu : String? = json.value(forKey: "ciudad") as? String
                    
                    self.ciudad.text = ciu
                    
                    let  dir : String? = json.value(forKey: "direccion") as? String
                    
                    self.direccion.text = dir
                    
                 let img : String? = json.value(forKey: "urlImagen") as? String
                    self.ima = img!
                    
                    print(img!)
                    print(self.ima)
        
                    
                    
                }
                
                
            }
            catch let error {
                print(error.localizedDescription)
            }
            }.resume()
        

        
        //asdasd
        
        
        print(ima)
      
    }

    @IBAction func llamar(_ sender: Any) {
        let url = URL(string: ima)
        let data = try? Data(contentsOf: url!)
        imageView.image = UIImage(data: data!)
    }
  
    
    }

