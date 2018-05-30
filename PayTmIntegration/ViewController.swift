//
//  ViewController.swift
//  PayTmIntegration
//
//  Created by Ruchin Somal on 30/05/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let paytmInstance = PaytmGateway.sharedInstance
        paytmInstance.createOrderWith(sender: self, customerID: "1234", amount: "10")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertView(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            //ref.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
extension ViewController: PayTmDelegateMethods {
    func didFinishedResponse(data: JSON) {
        guard data != JSON.null else {
            showAlertView(title: "Error", message: "Transection failed due to some error if your amount will deducted, we will refund you in 7 working days")
            return
        }
        if data["STATUS"].stringValue == "TXN_SUCCESS" {
            print("Success: \n\(String(describing: data))")
            showAlertView(title: "SUCCESS", message: data["TXNID"].stringValue)
        } else {
            showAlertView(title: "Error", message: "Transection Fail")
        }
    }
    
    func didCancelTrasaction() {
        showAlertView(title: "Error", message: "Transection cancel by user")
    }
    
    func errorMisssingParameter(error: Error!) {
        showAlertView(title: "Error", message: error.localizedDescription)
    }
}

