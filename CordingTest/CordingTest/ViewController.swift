//
//  ViewController.swift
//  CordingTest
//
//  Created by talln on 2017/07/30.
//  Copyright © 2017年 b-room. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	//==============================
	//MARK:- コントローラ
	//==============================
	
	@IBOutlet weak var mLabelAccessTokenTitle: UILabel!
	@IBOutlet weak var mLabelAccessToken: UILabel!
	@IBOutlet weak var mLabelRefreshTokenTitle: UILabel!
	@IBOutlet weak var mLabelRefreshToken: UILabel!
	@IBOutlet weak var mLabelExpiresInTitle: UILabel!
	@IBOutlet weak var mLabelExpiresIn: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		hidden(true);
		
		
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated);

	
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let vc = LoginViewController.instance;
		vc.delegate = self;
		self.present(vc, animated: true) {
			
		}
		
	}
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func hidden(_ flag:Bool){
		self.mLabelExpiresIn.isHidden = flag;
		self.mLabelAccessToken.isHidden = flag;
		self.mLabelRefreshToken.isHidden = flag;
		self.mLabelAccessTokenTitle.isHidden = flag;
		self.mLabelRefreshTokenTitle.isHidden = flag;
		self.mLabelExpiresInTitle.isHidden = flag;
		
	}
	
	
	
	@IBAction func clickButtonLoginView(_ sender: UIButton) {
		let vc = LoginViewController.instance;
		vc.delegate = self;
		self.present(vc, animated: true) {
			
		}
	}
	
	
}

//==============================
//
//MARK:- ログイン
//
//==============================
extension ViewController:LoginViewControllerDelegate{

	//----------------------------
	//MARK:-  ログイン成功
	//----------------------------
	func execLoginComplete(_ data: UserEntity) {
		DispatchQueue.main.async {
			self.hidden(false);
			
			self.mLabelAccessToken.text = data.access_token
			self.mLabelRefreshToken.text = data.refresh_token
			self.mLabelExpiresIn.text = String(data.expires_in)
		}
	}
}





