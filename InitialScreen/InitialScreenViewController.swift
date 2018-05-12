//
//  ViewController.swift
//  Library
//
//  Created by Даниил Смирнов on 04.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit
import RealmSwift

class InitialScreenViewController: UIViewController {

	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	var manager: NetworkManager!
	
	weak var viewOutput: InitialViewOutput?
	var realm: Realm?
	
	override func loadView() {
		super.loadView()
		self.manager = NetworkManager()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	private func areFieldEmpty() -> Bool {
		
		if loginTextField.text! != "" && passwordTextField.text! != "" {
			return false
		}
		return true
	}
	
	@IBAction func loginButtonPressed(_ sender: Any) {
		manager.signIn(with: loginTextField.text!, and: passwordTextField.text!) { (status, message, error) in

			let alert = UIAlertController(title: "Message", message: error, preferredStyle: .alert)
			let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			alert.addAction(okAction)
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
//		guard let tabBarViewController = segue.destination as? UITabBarController else {
//			print("Could not cast tab bar view controller")
//			return
//		}
//
//		guard let navController = tabBarViewController.viewControllers?[0] as? UINavigationController else {
//			print("Could not cast nav controller")
//			return
//		}
//
//		guard let destinationVc = navController.childViewControllers[0] as? BookViewController else {
//			print("Could not cast destination controller")
//			return
//		}
//
//		self.viewOutput = destinationVc
	}
}

