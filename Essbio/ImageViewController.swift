//
//  ImageViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 03-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
   
    var itemIndex: Int = 0
    var imageName: String = ""
    {
        didSet {
            
            if let imageView = asdasd{
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    
    
    @IBOutlet weak var asdasd: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asdasd.image = UIImage(named: imageName)
       
    /*
        if itemIndex == 0 {
        label.text = "primera imagen"
        }
        if itemIndex == 1 {
            label.text = "segunda imagen"
        }
        if itemIndex == 2 {
            label.text = "tercer imagen"
        }
        if itemIndex == 3 {
            label.text = "cuarta imagen"
        }
        if itemIndex == 4 {
            label.text = "quinta imagen"
        }
        
   */
    }
    
    
// boton q lleva al perfil de facebook de essbio a traves de la app
    @IBAction func face(_ sender: UIButton) {
        
        if let url = NSURL(string: "fb://profile/1593021084292048"){
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    // boton q lleva al perfil de twitter de essbio a traves de la app
    @IBAction func twitter(_ sender: Any) {
        
        if let url = NSURL(string: "twitter://user?screen_name=essbio"){
            
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
}
