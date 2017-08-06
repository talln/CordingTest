//
//  APIManager.swift
//  CordingTest
//
//  Created by talln on 2017/07/30.
//  Copyright © 2017年 b-room. All rights reserved.
//

import Alamofire
import SwiftyJSON


enum Result<SUCCESS, ERROR: Error> {
	case success(SUCCESS)
	case failure(ERROR)
	
	init(value: SUCCESS) {
		self = .success(value)
	}
	
	var value: SUCCESS? {
		switch self {
		case .success(let value):
			return value
		default:
			return nil
		}
	}
	
	var error: ERROR? {
		switch self {
		case .failure(let error):
			return error
		default:
			return nil
		}
	}
}

struct APIManager {
	let url: String
	let method: HTTPMethod
	let parameters: Parameters
	
	
	init(url: String, method: HTTPMethod = .post, parameters: Parameters = [:]) {
		self.url = url
		self.method = method
		self.parameters = parameters
	}
	
	func request(success: @escaping (_ data: JSON)-> Void, fail: @escaping (_ error: Error?)-> Void) {
		Alamofire.request(url, method: method, parameters: parameters).responseJSON { response in
			//成功
			if( response.result.isSuccess ){
				success(JSON(response.result.value!))
				return;
			}
			
			//失敗
			fail(response.result.error)
			
			
			
		}
		
	}
}






