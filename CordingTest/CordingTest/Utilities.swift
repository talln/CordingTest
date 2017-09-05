//
//  Utilities.swift
//  CordingTest
//
//  Created by talln on 2017/07/30.
//  Copyright © 2017年 b-room. All rights reserved.
//

import Foundation

import UIKit


class Utilities:NSObject{
	
	//==============================
	//
	//MARK:- 簡易アラート表示
	//
	//==============================
	class func showAlertOK(_ vc:UIViewController, title:String, message:String ){
		let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:  UIAlertControllerStyle.alert)
		
		let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
			(action: UIAlertAction!) -> Void in
			print("OK")
		})
		
		alert.addAction(defaultAction)
		
		vc.present(alert, animated: true, completion: nil)
	}
	
}



