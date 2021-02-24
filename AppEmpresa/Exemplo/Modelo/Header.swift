//
//  Header.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 08/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

struct Header: Mappable {
    
    var investor: String
    
    init(mapper: Mapper) {
        
        self.investor = mapper.keyPath("investor")
        
    }
}
