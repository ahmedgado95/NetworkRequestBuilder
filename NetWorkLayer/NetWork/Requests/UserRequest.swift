//
//  UserRequest.swift
//  NetWorkLayer
//
//  Created by A on 03/03/2020.
//  Copyright © 2020 Ahmed Gado. All rights reserved.
//

import Foundation

 import Alamofire

 enum UserRouter: URLRequestBuilder {

     case getSearch(fullAdress: String)
     
     // MARK: - Path
     internal var path: String {
         switch self {
         case .getSearch:
            return Constants.Search
      
         }
     }

     // MARK: - Parameters
     internal var parameters: Parameters? {
         var params = Parameters.init()
         switch self {
         case .getSearch(let fullAdress):
            params[""] = fullAdress
         }
         return params
     }
     
     // MARK: - Methods
     internal var method: HTTPMethod {
         return .post
     }
     
     
     
    
 }

