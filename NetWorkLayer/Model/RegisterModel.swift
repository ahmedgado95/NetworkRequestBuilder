//
//  RegisterModel.swift
//  NetWorkLayer
//
//  Created by ahmed gado on 3/18/20.
//  Copyright © 2020 Ahmed Gado. All rights reserved.
//

import Foundation
struct RegisterModel : Codable , CodableInit {
    let message : String?
    let key : Int?
    let data : DataModel?
    
}
struct DataModel : Codable {
let id : Int?
let name : String?
let email : String?
let email_verified_at : String?
let api_token : String?
let photo : String?
let document : String?
let status : Int?
let star : Int?
let reason : String?
let block_by : Int?
let type : Int?
let area : String?
let neighborhood : String?
let birthday : String?
let code : String?
let phone : String?
let phone_code : String?
let address : String?
let area_work : String?
let email_num : String?
let created_at : String?
let updated_at : String?
}
