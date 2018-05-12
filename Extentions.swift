//
//  Extentions.swift
//  Library
//
//  Created by Даниил Смирнов on 14.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit

extension UIAlertController {
	
	static func showServerErorrAlert(with errorCode: Int, for controller: UIViewController) {
		
		let alert = UIAlertController(title: "Server error", message: "Code = \(errorCode)", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		alert.addAction(okAction)
		controller.present(alert, animated: true , completion: nil)
	}
}
