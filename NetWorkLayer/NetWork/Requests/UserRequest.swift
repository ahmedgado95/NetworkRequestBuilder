//
//  UserRequest.swift
//  NetWorkLayer
//
//  Created by A on 03/03/2020.
//  Copyright © 2020 Ahmed Gado. All rights reserved.
//

import Foundation

 import Alamofire

 enum SearchRouter: URLRequestBuilder {

     case getSearch(fullAdress: String)
    case register( name: String , email: String , password: String , code: String , phone: String)
     
     // MARK: - Path
     internal var path: String {
         switch self {
         case .getSearch:
            return Constants.Search
            
      
         case .register:
            return Constants.Register
        }
     }

     // MARK: - Parameters
     internal var parameters: Parameters? {
         var params = Parameters.init()
         switch self {
         case .getSearch(let fullAdress):
            params[""] = fullAdress
         case .register(let name, let email, let password, let code, let phone):
            params["name"] = name
            params["email"] = email
            params["password"] = password
            params["code"] = code
            params["phone"] = phone
        }
         return params
     }
     
     // MARK: - Methods
     internal var method: HTTPMethod {
         return .post
     }
     
     
     
    
 }

