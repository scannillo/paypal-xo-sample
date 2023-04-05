//
//  ViewController.swift
//  PayPalXOSampleApp
//
//  Created by Samantha Cannillo on 4/5/23.
//

import UIKit
import PayPalCheckout

class ViewController: UIViewController {
    
    var orderID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.sharedInstance.createOrderID { result in
            switch result {
            case .success(let orderID):
                self.orderID = orderID
                
                self.addPayPalButtons()
                self.configurePayPalCheckout()
            case .failure(let error):
                print("🚩 Error occured fetching orderID: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - PayPal Checkout

    private func configurePayPalCheckout() {
        Checkout.setCreateOrderCallback { createOrderAction in
            createOrderAction.set(orderId: self.orderID!)
        }
        
        Checkout.setOnApproveCallback { approval in
            approval.actions.capture { response, error in
                // Handle result of order approval (authorize or capture)
            }
        }
        
        Checkout.setOnCancelCallback {
            // Handle cancel case
        }
        
        Checkout.setOnErrorCallback { error in
            // Handle error case
        }
        
        Checkout.setOnShippingChangeCallback { shippingChange, shippingChangeAction in
            // Handle user shipping address & method selection change
        }
    }
        
    private func addPayPalButtons() {
        let container = PaymentButtonContainer()

        DispatchQueue.main.async {
            self.view.addSubview(container)
            NSLayoutConstraint.activate(
                [
                    container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                ]
            )
        }
    }
}

