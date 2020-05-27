//
//  Moneda.swift
//  webserviceMonedas
//
//  Created by alex on 29/04/20.
//  Copyright © 2020 alex. All rights reserved.
//

import Foundation
class Monedas{
    var description:String?
    var rate:String?
    var code: String?
    
    init(description:String?, rate:String?, code:String?) {
        self.description = description
        self.rate = rate
        self.code = code
    }
}
