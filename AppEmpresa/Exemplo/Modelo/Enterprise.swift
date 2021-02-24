//
//  Enterprise.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 08/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//

struct Enterprise: Mappable {
    
    var id: Int?
    var enterprise_name: String?
    var photo: String?
    var description: String?
    
    init(mapper: Mapper) {
        
        self.id = mapper.keyPath("id")
        self.enterprise_name = mapper.keyPath("enterprise_name")
        self.photo = mapper.keyPath("photo")
        self.description = mapper.keyPath("description")
        
    }
}
