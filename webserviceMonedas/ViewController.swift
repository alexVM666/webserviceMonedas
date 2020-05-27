//
//  ViewController.swift
//  webserviceMonedas
//
//  Created by alex on 29/04/20.
//  Copyright © 2020 alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var monedas = [Monedas]()
    
    @IBAction func btnConsultar(_ sender: UIButton) {
        monedas.removeAll()
        let urlWiki = "https://api.coindesk.com/v1/bpi/currentprice.json"
        let urlObjeto = URL(string:urlWiki)
        let tarea = URLSession.shared.dataTask(with: urlObjeto!){(datos,respuesta,error)in
            if error == nil{
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers)as![String:Any]
                    let querySubJson = json["bpi"]as![String:Any]
                    
                    for money in querySubJson{
                        let pagesSubJson = querySubJson[money.key]as![String:Any]
                        let desc = pagesSubJson["description"]as! String
                        let cod = pagesSubJson["code"]as! String
                        let rat = pagesSubJson["rate"]as! String
                        //self.xxx = desc
                        self.monedas.append(Monedas(description:desc,rate:rat,code:cod))
                    }
                    DispatchQueue.main.sync(execute: {
                        self.performSegue(withIdentifier: "segue", sender: self)
                    })
                }catch let jsonErr {
                    print("El Procesamiento del JSON tuvo error",jsonErr)
                }
            }else{
                print(error!)
            }
        }
        tarea.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let seguex = segue.destination as! TableViewController
            seguex.monedasC = monedas
        }
    }

}

