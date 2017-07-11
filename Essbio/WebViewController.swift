//
//  WebViewController.swift
//  Essbio
//
//  Created by Matias Villagran on 19-06-17.
//  Copyright © 2017 Matias Villagran. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let urll = URL(string:"http://portal.aguasiot.cl/clientes/17853344-4/casas/3")
        
        webview.loadRequest(URLRequest(url:urll!))
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
