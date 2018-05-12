//
//  BookInfoViewController.swift
//  Library
//
//  Created by Даниил Смирнов on 20.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit
import RealmSwift

class BookInfoViewController: UIViewController {

	var realm: Realm?
	var book: Book!
	var titles = ["Название книги", "Автор", "Издательство", "Год издания", "Категория", "Носитель", "Кол-во страниц", "Статус"]
	@IBOutlet weak var coveImageView: UIImageView!
	var manager = NetworkManager()
	
	weak var viewOutput: BookViewOuptut?
	@IBOutlet weak var bookInfoTableView: UITableView!

	@IBAction func debookButtonPressed(_ sender: Any) {
		manager.bookBook(with: book.id) { (error) in
			print(error)
		}
	}
	
	@IBAction func bookedButtonPressed(_ sender: Any) {
		manager.bookBook(with: book.id) { (error) in
			print(error)
		}
	}
	
	override func loadView() {
		super.loadView()
		self.bookInfoTableView.delegate = self
		self.bookInfoTableView.dataSource = self
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension BookInfoViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return titles[section]
	}
}

extension BookInfoViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return titles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = bookInfoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		print(book.name)
		switch indexPath.section {
		case 0: // name
			cell.textLabel?.text = book.name
		case 1: // author
			cell.textLabel?.text = book.author
		case 2: // publishing office
			cell.textLabel?.text = book.publishingOffice
		case 3: //  year
			cell.textLabel?.text = "\(book.year)"
		case 4: // subject
			cell.textLabel?.text = book.subject
		case 5: //carrier
			cell.textLabel?.text = book.carrier
		case 6: // volume
			cell.textLabel?.text = "\(book.volume)"
		case 7: // status
			switch book.status {
			case .forExtradition:
				cell.textLabel?.text = "Для выдачи"
			case .unavailable:
				cell.textLabel?.text = "Недоступно"
			case .forInternalUse:
				cell.textLabel?.text = "Для внутреннего использования"
			case .booked:
				cell.textLabel?.text = "Забронировано"
			}
		default: break
		}
		
		return cell
	}
}












