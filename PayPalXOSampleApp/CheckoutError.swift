//
//  Errors.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

import Foundation

enum CheckoutError: Error {
    
    case networkError
    
    case missingData
    
    case dataParsingError
}
