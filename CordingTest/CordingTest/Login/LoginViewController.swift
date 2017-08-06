//
//  LoginViewController.swift
//  CordingTest
//
//  Created by talln on 2017/07/30.
//  Copyright © 2017年 b-room. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol LoginViewControllerDelegate {
	func execLoginComplete(_ data:UserEntity)
}

class LoginViewController: UIViewController {

	
	//==============================
	//MARK:- 定数
	//==============================
	
	
	
	//==============================
	//MARK:- コントローラ
	//==============================
	
	@IBOutlet weak var mTextFieldMail: UITextField!
	
	@IBOutlet weak var mTextFieldPassword: UITextField!
	
	//==============================
	//MARK:- 変数
	//==============================
	
	var delegate:LoginViewControllerDelegate? = nil
	
	var mIsLoading = false;
	
	//----------------------------
	//MARK:- インスタンス
	//----------------------------
	static var instance:LoginViewController{
		let vc = LoginViewController()
		vc.modalPresentationStyle = .overCurrentContext
		vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
		return vc
	}
	
	//==============================
	//
	//MARK:- システム
	//
	//==============================
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		//テスト用
		mTextFieldMail.text = "c0ban+test_cast@lastroots.com"
		mTextFieldPassword.text = "password123"
		
		SVProgressHUD.setMinimumDismissTimeInterval(1.0)
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		mTextFieldMail.becomeFirstResponder()
	}
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	
	//==============================
	//
	//MARk:- コントローラ
	//
	//==============================
	//----------------------------
	//	ログインボタン
	//----------------------------
	@IBAction func clickButtonLogin(_ sender: UIButton) {
		
		if( mTextFieldMail.text!.isEmpty ){
			Utilities.showAlertOK(self, title: "Input Error", message: "email input is incorrect")
			return;
		}
		
		if( mTextFieldPassword.text!.isEmpty ){
			Utilities.showAlertOK(self, title: "Input Error", message: "Password input is incorrect")
			return;
		}
		
		if( mIsLoading ){
			return;
		}
		
		mIsLoading = true;
		SVProgressHUD.show()
		UserModel.login( email: mTextFieldMail.text!, password: mTextFieldPassword.text!) { result in
			self.mIsLoading = false;
			guard result.error == nil else {
				//エラー
				SVProgressHUD.dismiss()
				Utilities.showAlertOK(self, title: "Login Error", message: "Server connection error.")
				return
			}
			
			//エラーが返ってきた
			let data = result.value
			if( 0 < data!.error_subcode ){
				
				SVProgressHUD.dismiss()
				Utilities.showAlertOK(self, title: data!.error_user_title, message: data!.error_user_msg)
				return;
			}
			
			//サーバー接続系エラー
			if( 200 < data!.status ){
				SVProgressHUD.dismiss()
				Utilities.showAlertOK(self, title: "Login Error", message: "Server connection error.")
				return;
			}
			
			
			//成功
			SVProgressHUD.showSuccess(withStatus:"Login Success")
			self.mTextFieldMail.resignFirstResponder();
			self.mTextFieldPassword.resignFirstResponder();
			self.dismiss(animated: true, completion: {
				self.delegate!.execLoginComplete(data!);
			})
			
			
		}
		
	}
	
	
}
