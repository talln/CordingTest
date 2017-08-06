//
//  LoginModel.swift
//  CordingTest
//
//  Created by talln on 2017/07/30.
//  Copyright © 2017年 b-room. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//==============================
//
//MARK:- ユーザーエンティティ
//
//==============================
struct UserEntity{
	var access_token = ""
	var refresh_token = ""
	var expires_in = 0
	
	//エラー関連
	var reason = ""
	var message = ""
	var error_user_msg = ""
	var error_user_title = ""
	var domain = ""
	var error_subcode = 0
	var status = 0
	
	init(){
		self.access_token = ""
		self.refresh_token = ""
		self.expires_in = 0
		
		//エラー関連
		self.reason = ""
		self.message = ""
		self.error_user_msg = ""
		self.error_user_title = ""
		self.domain = ""
		self.error_subcode = 0
		self.status = 0
		
	}
	
	init(_ data:JSON){
		self.access_token = data["access_token"].stringValue
		self.refresh_token = data["refresh_token"].stringValue
		self.expires_in = data["expires_in"].intValue
		
		//エラー関連
		self.reason = data["reason"].stringValue
		self.message = data["message"].stringValue
		self.error_user_msg = data["error_user_msg"].stringValue
		self.error_user_title = data["error_user_title"].stringValue
		self.domain = data["domain"].stringValue
		self.error_subcode = data["error_subcode"].intValue
		self.status = data["status"].intValue
		
		
	}
	
	
	
}

//==============================
//
//MARK:- ユーザーモデル
//
//==============================

class UserModel:NSObject{
	
	enum eStatus {
		case last
		case error
		case normal
	}
	
	var mStatus = eStatus.normal
	
	
	
}

//==============================
//
//MARK:- ユーザーモデル（ログイン）
//
//==============================
extension UserModel{
	
	enum eURL:String{
		case login = "https://staging.c0ban-api.com/oauth2/token"
		case login_error_test = "https://staging.c0ban-api.com"
	}
	
	class func login( email:String,password:String,
	                   compleation: @escaping(Result<UserEntity,NSError>)->Void) {

		let parameters = [
			"email":email,
			"password":password
		]
		
		let api = APIManager(url:eURL.login.rawValue,method:.post,parameters:parameters)
	
		api.request(
			success: {
				(data) in
				let user = UserEntity(data);
				compleation(.success(user))
			
		},
			fail: {
				error in
				compleation(.failure(error! as NSError))
		})
	}
	
}







