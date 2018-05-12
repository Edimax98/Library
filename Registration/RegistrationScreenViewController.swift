//
//  RegistrationScreenViewController.swift
//  Library
//
//  Created by Даниил Смирнов on 10.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit
import RealmSwift

class RegistrationScreenViewController: UIViewController {

	@IBOutlet weak var fioTextField: UITextField!
	@IBOutlet weak var passportNumberTextField: UITextField!
	@IBOutlet weak var phoneNumberTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	var realm: Realm?
	var manager: NetworkManager!
	weak var viewOutput: RegistrationViewOutput?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		manager = NetworkManager()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func isFioCorrect(_ fio: String) -> Bool {
		
		let separator: Character = " "
		
		if fio.split(separator: separator).count < 2 {
			return false
		}
		return true
	}
	
	func areTextFieldsEmpty() -> Bool {
		
		if fioTextField.text!.isEmpty || passportNumberTextField.text!.isEmpty ||
			phoneNumberTextField.text!.isEmpty || emailTextField.text!.isEmpty ||
			passwordTextField.text!.isEmpty {
			return false
		}
		
		return true
	}
	
	private func showAlertOfEmptyFields() {
		
		let alert = UIAlertController(title: "Ой", message: "Вы не заполнили необходимые поля", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(okAction)
		self.present(alert, animated: true , completion: nil)
	}
	
	private func showAlertFieldFilledIncorrectly(_ fieldName: String) {
		
		let alert = UIAlertController(title: "Ой", message: "Вы неверно заполнили поле \(fieldName)", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(okAction)
		self.present(alert, animated: true , completion: nil)
	}
	
	private func showAlertForSuccessfulRegistration() {
		
		let alert = UIAlertController(title: nil, message: "Регистрация прошла успешно", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(okAction)
		self.present(alert, animated: true , completion: nil)
	}
	
	private func clearFields() {
		
		fioTextField.text = nil
		emailTextField.text = nil
		passwordTextField.text = nil
		phoneNumberTextField.text = nil
		passportNumberTextField.text = nil
	}
	
	func isUserHasPatronymic(_ fio: String) -> Bool {
		
		if fio.split(separator: " ").count != 3 {
			return false
		}
		return true
	}
	
	@IBAction func signinButtonPressed(_ sender: Any) {
		
		if !areTextFieldsEmpty() {
			showAlertOfEmptyFields()
			return
		}
		
		if !isFioCorrect(fioTextField.text!) {
			showAlertFieldFilledIncorrectly("ФИО")
			return
		}

				manager.signUp(with: User(name: String(fioTextField.text!.split(separator: " ").first!), surname: String(fioTextField.text!.split(separator: " ")[1]), patronymic: String(fioTextField.text!.split(separator: " ").last!), passportNumber: passwordTextField.text!, phone: phoneNumberTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, position: .client)) { (error) in
			print(error)
		}
		
		clearFields()
		showAlertForSuccessfulRegistration()
	}
}
