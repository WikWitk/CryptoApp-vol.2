//
//  Currency.swift
//  CryptoAppvol.2
//
//  Created by Wiktor Witkowski on 12/03/2024.
//

import Foundation

struct Currency : Decodable, Identifiable, Hashable {
    
    
    let currency : String
    let price : String
    let id = UUID()
    
    
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
    
}
