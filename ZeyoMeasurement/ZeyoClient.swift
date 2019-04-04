//
//  ZeyoClient.swift
//  ZeyoMeasurement
//
//  Created by Susan Kim on 04/04/2019.
//  Copyright © 2019 Susan Kim. All rights reserved.
//

import Foundation

let zeyoClient = ZeyoClient()

class ZeyoClient {
    static let baseURL = "http://hulk.zeyo.co.kr:5002/api/documents"
    static var clothes: [Cloth] = []
    
    func getAllClothes(completionHandler: @escaping (/*_ error: Error?*/) -> Void) {
        ZeyoClient.clothes = []
        let count = Int.random(in: 7 ... 23)
        for _ in 0...count {
            ZeyoClient.clothes.append(Cloth(random: true))
        }
         completionHandler(/*error*/)
    }
    
    func postCloth(cloth: Cloth, completionHandler: @escaping (/*_ error: Error?*/) -> Void) {
        // TODO: remove this after sync with server
        ZeyoClient.clothes.append(cloth)
        completionHandler(/*error*/)
    }
    
    func putCloth(id: String, cloth: Cloth, completionHandler: @escaping (/*_ error: Error?*/) -> Void) {
        completionHandler(/*error*/)
    }
    
    func deleteCloth(id: String, completionHandler: @escaping (/*_ error: Error?*/) -> Void) {
        completionHandler(/*error*/)
    }
}
