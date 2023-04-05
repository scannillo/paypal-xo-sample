//
//  Networking.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

import Foundation

class Networking {
    
    static let sharedInstance = Networking()
    
    private let sampleMerchantServerURL = "https://sdk-sample-merchant-server.herokuapp.com"
    
    private init() {}
    
    func createAccessToken(completion: @escaping (Result<String, Error>) -> Void)  {
        guard let url = URL(string: sampleMerchantServerURL + "/access_tokens") else {
            completion(.failure(CheckoutError.networkError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(.failure(CheckoutError.networkError))
            }
            
            guard let data = data else {
                completion(.failure(CheckoutError.missingData))
                return
            }

            do {
                let accessTokenResult = try JSONDecoder().decode(AccessTokenResult.self, from: data)
                completion(.success(accessTokenResult.accessToken))
            } catch {
                completion(.failure(CheckoutError.dataParsingError))
            }
        }.resume()
    }
    
    func createOrderID(completion: @escaping (Result<String, Error>) -> Void)  {
        guard let url = URL(string: sampleMerchantServerURL + "/orders") else {
            completion(.failure(CheckoutError.networkError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        // create order params
        let purchaseUnit = PurchaseUnit(amount: Amount(currencyCode: "USD", value: "10.00"))
        let orderParams = OrderRequest(intent: "CAPTURE", purchaseUnits: [purchaseUnit])
        
        urlRequest.httpBody = try! encoder.encode(orderParams)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(.failure(CheckoutError.networkError))
            }
            
            guard let data = data else {
                completion(.failure(CheckoutError.missingData))
                return
            }

            do {
                let order = try JSONDecoder().decode(OrderResult.self, from: data)
                completion(.success(order.id))
            } catch {
                completion(.failure(CheckoutError.dataParsingError))
            }
        }.resume()
    }
}
