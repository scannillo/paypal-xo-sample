//
//  AccessTokenResult.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

public struct AccessTokenResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }

    let accessToken: String
}
