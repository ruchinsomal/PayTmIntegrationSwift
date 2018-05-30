
//
//  PaytmGateway.swift
//  PayTmIntegration
//
//  Created by Ruchin Somal on 30/05/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import UIKit

protocol PayTmDelegateMethods {
    func didFinishedResponse(data: JSON)
    func didCancelTrasaction()
    func errorMisssingParameter(error: Error!)
}

class PaytmGateway: NSObject, PGTransactionDelegate {
    
    static var sharedInstance  = PaytmGateway()
    // this is the url of your API to generate checksum which is on the server side of you app
    private let CheckSumGenerationURL = "http://192.168.1.13:8080/demo/generate/checksum"
    private var root : UIViewController!
    var delegate: PayTmDelegateMethods?
    
    
    override init() {
        super.init()
        merchantConfiguration()
    }
    
    
    private func merchantConfiguration() {
    }
    
    func createOrderWith(sender: UIViewController, customerID: String, amount: String) {
        root = sender
        delegate = sender as? PayTmDelegateMethods
        getCheckSum(customerID: customerID, amount: amount, user_email: "abc@gmail.com", user_mobile: "9999999999")
    }
    
    func showTransectionController(txn_amount: String, orderId: String, checksumhash: String, cust_id: String, mobile_no: String, email: String) {
        let orderDict = PaytmOrder(txn_amount: txn_amount, orderId: orderId, mobile_no: mobile_no, email: email, checksumhash: checksumhash, cust_id:cust_id)
        let order = PGOrder(params: orderDict.getParamDict())
        
        let txnController = PGTransactionViewController(transactionFor: order)
        txnController?.serverType = eServerTypeStaging
        txnController?.merchant = PGMerchantConfiguration.default()
        txnController?.delegate = self
        root.show(txnController!, sender: nil)
        
        
        
        struct PaytmOrder {
            static let mid = "XXXXXXXXXXXXXXXXXXXXXX" // your MID provided by the paytm
            static let channel_id = "WAP" // your CHANNEL_ID provided by the paytm
            static let industry_type_id = "Retail" // your INDUSTRY_TYPE_ID provided by the paytm
            static let website = "WEBSTAGING" // your WEBSITE provided by the paytm
            static let callback_url = "https://securegw.paytm.in/theia/paytmCallback" // your CALLBACK_URL provided by the paytm
            var txn_amount = ""
            var orderId = ""
            var mobile_no = ""
            var email = ""
            var checksumhash = ""
            var cust_id = ""
            
            func getParamDict() -> [AnyHashable:Any] {
                // Make sure that these all params(except CHECKSUMHASH) should be used in the checksum generation api on your server side otherwise your payment gateway give some error
                var paramDict = [AnyHashable:Any]()
                paramDict["MID"] = PaytmOrder.mid
                paramDict["CHANNEL_ID"] = PaytmOrder.channel_id
                paramDict["INDUSTRY_TYPE_ID"] = PaytmOrder.industry_type_id
                paramDict["WEBSITE"] = PaytmOrder.website
                paramDict["CALLBACK_URL"] = PaytmOrder.callback_url + orderId
                paramDict["TXN_AMOUNT"] = txn_amount
                paramDict["ORDER_ID"] = orderId
                paramDict["MOBILE_NO"] = mobile_no
                paramDict["EMAIL"] = email
                paramDict["CHECKSUMHASH"] = checksumhash
                paramDict["CUST_ID"] = cust_id
                
                return paramDict
            }
        }
    }
    
    func didFinishedResponse(_ controller: PGTransactionViewController!, response responseString: String!) {
        let data = responseString.data(using: .utf8)!
        let obj = JSON(data: data)
        if obj["STATUS"].stringValue != "TXN_SUCCESS" {
            root.navigationController?.popViewController(animated: true)
        }
        delegate?.didFinishedResponse(data: obj)
    }
    
    func didCancelTrasaction(_ controller: PGTransactionViewController!) {
        root.navigationController?.popViewController(animated: true)
        delegate?.didCancelTrasaction()
    }
    
    func errorMisssingParameter(_ controller: PGTransactionViewController!, error: Error!) {
        root.navigationController?.popViewController(animated: true)
        delegate?.errorMisssingParameter(error: error)
    }
    
    
    //-----------------------------------------------------------
    // MARK: - API call to your server to generate checksum
    //-----------------------------------------------------------
    
    
    func getCheckSum(customerID:String, amount:String, user_email:String, user_mobile:String) {
        MyLoader.showLoadingView()
        let params:[String: Any] = ["customerId":customerID, "amount":amount, "email":user_email, "phone":user_mobile]
        printLog(log: params)
        postRequest(CheckSumGenerationURL, params: params as [String : AnyObject]?,oauth: true, result: {
            (response: JSON?, error: NSError?, statuscode: Int) in
            MyLoader.hideLoadingView()
            guard error == nil else {
                return
            }
            if response!["status"].stringValue == "fail" {
                printLog(log: response!["reason"].stringValue)
            } else {
                printLog(log: response!)
                if statuscode == 200
                {
                    self.showTransectionController(txn_amount: response!["TXN_AMOUNT"].stringValue, orderId: response!["ORDER_ID"].stringValue, checksumhash: response!["CHECKSUMHASH"].stringValue, cust_id: response!["CUST_ID"].stringValue, mobile_no: user_mobile, email: user_email)
                }
            }
        })
    }
}
