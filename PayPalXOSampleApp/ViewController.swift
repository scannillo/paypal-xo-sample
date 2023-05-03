//
//  ViewController.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

import UIKit
import PayPalNativePayments
import CorePayments
import PaymentButtons

class ViewController: UIViewController {
    
    var orderID: String?
    var coreConfig: CoreConfig?
    var paypalClient: PayPalNativeCheckoutClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.sharedInstance.createAccessToken { result in
            switch result {
            case .success(let accessToken):
                print("✅ Fetched accessToken.")
                self.configurePayPalCheckout(accessToken: accessToken)
                
            case .failure(let error):
                print("🚩 Error occured fetching accessToken: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - PayPal Checkout

    private func configurePayPalCheckout(accessToken: String) {
        coreConfig = CoreConfig(accessToken: accessToken, environment: CorePayments.Environment.sandbox)
        paypalClient = PayPalNativeCheckoutClient(config: coreConfig!)
        paypalClient?.delegate = self
        paypalClient?.shippingDelegate = self
        
        Networking.sharedInstance.createOrderID { result in
            switch result {
            case .success(let orderID):
                print("✅ Fetched orderID.")
                self.orderID = orderID
                
                self.addPayPalButtons()
            case .failure(let error):
                print("🚩 Error occured fetching orderID: \(error.localizedDescription)")
            }
        }
    }
        
    private func addPayPalButtons() {
        let payPalButton = PaymentButtons.PayPalButton()
        payPalButton.addTarget(self, action: #selector(payPalButtonTapped), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.view.addSubview(payPalButton)
            NSLayoutConstraint.activate(
                [
                    payPalButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    payPalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ]
            )
        }
    }
    
    @objc private func payPalButtonTapped() {
        let request = PayPalNativeCheckoutRequest(orderID: orderID!)
        Task { await self.paypalClient?.start(request: request) }
    }
}

extension ViewController: PayPalNativeCheckoutDelegate {
    
    func paypal(_ payPalClient: PayPalNativePayments.PayPalNativeCheckoutClient, didFinishWithResult result: PayPalNativePayments.PayPalNativeCheckoutResult) {
        // Handle result of order approval (authorize or capture)
    }
    
    func paypal(_ payPalClient: PayPalNativePayments.PayPalNativeCheckoutClient, didFinishWithError error: CorePayments.CoreSDKError) {
        // Handle error case
    }
    
    func paypalDidCancel(_ payPalClient: PayPalNativePayments.PayPalNativeCheckoutClient) {
        // Handle cancel case
    }
    
    func paypalWillStart(_ payPalClient: PayPalNativePayments.PayPalNativeCheckoutClient) {
        // Handle any UI clean-up before paysheet presents
    }
}

extension ViewController: PayPalNativeShippingDelegate {
    
    func paypal(_ payPalClient: PayPalNativePayments.PayPalNativeCheckoutClient, didShippingAddressChange shippingAddress: PayPalNativePayments.PayPalNativeShippingAddress, withAction shippingActions: PayPalNativePayments.PayPalNativePaysheetActions) {
        // Handle user shipping address selection change
    }
    
    func paypal(_ payPalClient: PayPalNativePayments.PayPalNativeCheckoutClient, didShippingMethodChange shippingMethod: PayPalNativePayments.PayPalNativeShippingMethod, withAction shippingActions: PayPalNativePayments.PayPalNativePaysheetActions) {
        // Handle user shipping method selection change
    }
}
