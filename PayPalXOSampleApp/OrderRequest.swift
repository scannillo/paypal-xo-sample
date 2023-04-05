//
//  CreateOrderParams.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

import Foundation

struct OrderRequest: Codable {
    let intent: String
    let purchaseUnits: [PurchaseUnit]
}

struct PurchaseUnit: Codable {
    let amount: Amount
}

struct Amount: Codable {
    let currencyCode, value: String
}
