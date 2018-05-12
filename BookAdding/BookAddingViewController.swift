//
//  BookAddingViewController.swift
//  Library
//
//  Created by Даниил Смирнов on 19.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit
import RealmSwift

class BookAddingViewController: UIViewController {

	@IBOutlet weak var coverImageView: UIImageView!
	@IBOutlet weak var bookNameTectField: UITextField!
	@IBOutlet weak var authorTextField: UITextField!
	@IBOutlet weak var publishingOfficeTextField: UITextField!
	@IBOutlet weak var yearTextField: UITextField!
	@IBOutlet weak var subjectTextField: UITextField!
	@IBOutlet weak var carrierTextField: UITextField!
	@IBOutlet weak var volumeTextFielf: UITextField!
	@IBOutlet weak var scrollView: UIScrollView!

	var realm: Realm?
	var keyboardHeight: CGFloat = 0
	
	deinit {
		NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
		self.view.addGestureRecognizer(tapGesture)
		self.navigationController?.navigationController?.navigationItem.largeTitleDisplayMode = .never
	}
	
	@objc func screenTapped() {
		self.view.endEditing(true)
		self.animateTextfield(up: false)
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			//keyboardHeight = keyboardSize.height
			//self.animateTextfield(up: true)
		}
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
		}
		//self.animateTextfield(up: false)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func addBookButtonPressed(_ sender: Any) {
		
	}
	
	func animateTextfield(up: Bool) {
		var movement = (up ? -keyboardHeight : keyboardHeight)
		
		UIView.animate(withDuration: 0.3, animations: {
			self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
		})
	}
	
}

extension BookAddingViewController: UITextFieldDelegate {
	
}









