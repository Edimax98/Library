//
//  BookViewController.swift
//  Library
//
//  Created by Даниил Смирнов on 13.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit
import RealmSwift

class BookViewController: UIViewController {
	
	@IBOutlet weak var bookCollectionView: UICollectionView!
	private var currentUser: User?
	weak var viewOutput: BookViewOuptut?
	var books: [Book]!
	var realm: Realm?
	var selectedBook: Book!
	
	override func loadView() {
		super.loadView()
		
		bookCollectionView.delegate = self
		bookCollectionView.dataSource = self

		guard let realm = self.realm else {
			print("Realm instance is nil")
			return
		}
		//books = realm.objects(Book.self).map({$0})
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.bookCollectionView.register(UINib(nibName: "BookCellView", bundle: nil), forCellWithReuseIdentifier: "bookCell")
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
//		books = realm!.objects(Book.self).map({$0})
//		self.bookCollectionView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "bookSelected" {
			
			guard let destinationVc = segue.destination as? BookInfoViewController else {
				print("Error")
				return
			}
			//self.viewOutput = destinationVc
		}
	}
}

extension BookViewController: BookViewInput {

	func clientLoggedIn(as user: User) {
		self.currentUser = user
	}
	
	func clientRegistred(as user: User) {
		self.currentUser = user
	}
}


extension BookViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "bookSelected", sender: self)
		self.viewOutput?.bookWasSelected(indexPath.row)
	}
}

extension BookViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1//books.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCell else {
			fatalError()
		}
		
		switch indexPath.row {
		case 0:
			cell.coverImageView.image = UIImage(named: "war")
		case 1:
			cell.coverImageView.image = UIImage(named: "master")
		case 2:
			cell.coverImageView.image = UIImage(named: "crime")
		case 3:
			cell.coverImageView.image = UIImage(named: "father")
		default: break
		}
		
		cell.contentView.layer.cornerRadius = 2.0
		cell.contentView.layer.borderWidth = 1.0
		cell.contentView.layer.borderColor = UIColor.clear.cgColor
		cell.contentView.layer.masksToBounds = true
		cell.layer.shadowColor = UIColor.lightGray.cgColor
		cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		cell.layer.shadowRadius = 2.0
		cell.layer.shadowOpacity = 1.0
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
		
			//cell.authorLabel.text = books[indexPath.row].author
			//cell.nameLabel.text = books[indexPath.row].name
			//cell.volumeLabel.text = "\(books[indexPath.row].volume)"
			
			//if let cover = books[indexPath.row].cover {
//				/cell.coverImageView.image =
			//}
		
		return cell
	}
}









