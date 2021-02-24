//
//  Enterprise.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 09/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

struct Enterprises: Mappable {
    
    var enterprises: [Enterprise]
    
    init(mapper: Mapper) {
        
        self.enterprises = mapper.keyPath("enterprises")
        
    }
}
