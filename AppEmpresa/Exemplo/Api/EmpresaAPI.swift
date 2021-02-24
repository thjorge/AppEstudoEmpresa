//
//  AuthenticationAPI.swift
//  Exemplo
//
//  Created by Thiago Jorge dos Santos on 10/02/21.
//  Copyright © 2020 Thiago Jorge dos Santos. All rights reserved.
//
import UIKit

class EmpresaAPI: APIRequest {

    override init(method: API.HTTPMethod, path: String, parameters: [String : Any]?, urlParameters: [String : Any]?, cacheOption: API.CacheOption, completion: ResponseBlock<Any>?) {
        super.init(method: method, path: path, parameters: parameters, urlParameters: urlParameters, cacheOption: cacheOption, completion: completion)
        
        self.baseURL = URL(string: "https://empresas.ioasys.com.br/api/v1/")!
    }
    
    @discardableResult
    static func logar(authDictionary: [String: Any], callback: ResponseBlock<Header>?) -> EmpresaAPI {
        
        let request = EmpresaAPI(method: .post, path: "users/auth/sign_in", parameters: authDictionary, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            if let error = error {
                print("Status Code: \(error.urlResponse?.statusCode)")
                print(error.responseObject ?? "nil")
                callback?(nil, error, cache)
            } else if let response = response as? [String: Any] {
                let header = Header(dictionary: response)
                callback?(header, nil, cache)
            }
        }
        request.shouldSaveInCache = false
        
        request.makeRequest()
        return request
    }
    
    @discardableResult
    static func buscarEmpresas(callback: ResponseBlock<Enterprises>?) -> EmpresaAPI {
        
        let request = EmpresaAPI(method: .get, path: "enterprises", parameters: nil, urlParameters: nil, cacheOption: .networkOnly) { (response, error, cache) in
            
            if let error = error {
                print(error.responseObject ?? "nil")
            } else if let response = response as? [String: Any] {
                let enterprises = Enterprises(dictionary: response)
                callback?(enterprises, nil, cache)
            }
        }
        request.shouldSaveInCache = false
        
        request.makeRequest()
        return request
    }
}
