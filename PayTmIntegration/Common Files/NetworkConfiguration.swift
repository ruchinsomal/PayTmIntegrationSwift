//
//  NetworkConfiguration.swift
//  PayTmIntegration
//
//  Created by Ruchin Somal on 30/05/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import Foundation
import Alamofire


// Methods without oauth that send no headers
func getRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    Alamofire.request(url, method: .get, parameters: params)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                
                let jsonResponse = JSON(data: response.data!)
                
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                //printLog(log: response.result.error?.code)
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func getRequestE(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                
                let jsonResponse = JSON(data: response.data!)
                
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                //printLog(log: response.result.error?.code)
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func postRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .post, parameters: params)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                //printLog(log: response.response!.statusCode)
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func deleteRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .delete, parameters: params)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                //printLog(log: response.response!.statusCode)
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func putRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, isQuery:Bool = false, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    if isQuery {
    Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding.queryString)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                //printLog(log: response.response!.statusCode)
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
    } else {
        Alamofire.request(url, method: .put, parameters: params)
            .responseData { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                
                // Check status code 403 for authentication
                if response.result.error?._code == nil {
                    //printLog(log: response.response!.statusCode)
                    let jsonResponse = JSON(data: response.data!)
                    result(jsonResponse, nil, response.response!.statusCode)
                } else {
                    result(nil, response.result.error as NSError?, response.result.error!._code)
                }
        }
    }
}


// Methods without oauth and with JSON object
func getRequestWithJSON(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                
                let jsonResponse = JSON(data: response.data!)
                
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                //printLog(log: response.result.error?.code)
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func postRequestWithJSON(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                //printLog(log: response.response!.statusCode)
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func deleteRequestWithJSON(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                //printLog(log: response.response!.statusCode)
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func putRequestWithJSON(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            
            // Check status code 403 for authentication
            if response.result.error?._code == nil {
                //printLog(log: response.response!.statusCode)
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

// Methods used for sending custom headers
func getRequestWithHeader(_ url: String, params: [String: AnyObject]?, customHeaders: [String: String], result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    Alamofire.request(url, method: .get, parameters: params, headers: customHeaders)
        .responseData { response in
            
            
            if response.result.error?._code == nil {
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func postRequestWithHeader(_ url: String, params: [String: AnyObject]?, customHeaders: [String: String], result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    Alamofire.request(url, method: .post, parameters: params, headers: customHeaders)
        .responseData { response in
            
            if response.result.error?._code == nil {
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func deleteRequestWithHeader(_ url: String, params: [String: AnyObject]?, customHeaders: [String: String], result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    Alamofire.request(url, method: .delete, parameters: params, headers: customHeaders)
        .responseData { response in
            
            if response.result.error?._code == nil {
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func putRequestWithHeader(_ url: String, params: [String: AnyObject]?, customHeaders: [String: String], result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    Alamofire.request(url, method: .put, parameters: params, headers: customHeaders)
        .responseData { response in
            
            if response.result.error?._code == nil {
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}


func postRequestWithImage(url: String, params: [String: AnyObject]?,imageName: String,imageData: Array<Data>, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        multipartFormData.append(imageData[0], withName: imageName, fileName: imageName, mimeType: "image/jpg")
        
        for (key, value) in params! {
            multipartFormData.append(value.data!(using: String.Encoding.utf8.rawValue)!, withName: key)
        }
        
    }, to: url, encodingCompletion: { (encodingResult) in
        
        switch encodingResult {
        case .success(let upload, _, _):
            
            upload.responseJSON { response in
                
                
                if (response.result.value != nil)
                {
                    let jsonResponse = JSON(data: response.data!)
                    //printLog(log: jsonResponse)
                    result(jsonResponse, nil, response.response!.statusCode)
                }
                else
                {
                    result(nil, response.result.error as NSError?, response.result.error!._code)
                }
            }
            
        case .failure(let encodingError):
            printLog(log: encodingError)
        }
    })
}

func postRequestWithProfileImage(url: String, params: [String: AnyObject]?,imageData: Array<Data>, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        multipartFormData.append(imageData[0], withName: "profile_pic", fileName: "profile_pic", mimeType: "image/jpg")
        
        for (key, value) in params! {
            multipartFormData.append(value.data!(using: String.Encoding.utf8.rawValue)!, withName: key)
        }
        
    }, to: url, encodingCompletion: { (encodingResult) in
        
        switch encodingResult {
        case .success(let upload, _, _):
            
            upload.responseJSON { response in
                
                
                if (response.result.value != nil)
                {
                    let jsonResponse = JSON(data: response.data!)
                    //printLog(log: jsonResponse)
                    result(jsonResponse, nil, response.response!.statusCode)
                }
                else
                {
                    result(nil, response.result.error as NSError?, response.result.error!._code)
                }
            }
            
        case .failure(let encodingError):
            printLog(log: encodingError)
        }
    })
}

// To print any Log
func printLog(log: Any) {
    print(log)
}


