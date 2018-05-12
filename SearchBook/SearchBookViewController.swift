//
//  SearchBookViewController.swift
//  Library
//
//  Created by Даниил Смирнов on 21.04.2018.
//  Copyright © 2018 Даниил Смирнов. All rights reserved.
//

import UIKit
import RealmSwift

class SearchBookViewController: UIViewController {

	var books = [Book]()
	var filteredBooks = [Book]()
	var realm: Realm?
	weak var viewOutput: SearchBookViewOutput?

	@IBOutlet weak var searchedBookCollectionView: UICollectionView!
	let searchController = UISearchController(searchResultsController: nil)
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.searchedBookCollectionView.dataSource = self
		self.searchedBookCollectionView.delegate = self
		
		self.searchedBookCollectionView.register(UINib(nibName: "BookCellView", bundle: nil), forCellWithReuseIdentifier: "searchBook")
		
		
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Название книги"
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func searchBarIsEmpty() -> Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	func filterContentForSearchText(_ searchText: String) {
		filteredBooks = books.filter({( book : Book) -> Bool in
			return book.name.lowercased().contains(searchText.lowercased())
		})
		searchedBookCollectionView.reloadData()
	}
	
	func isFiltering() -> Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
	}
}

extension SearchBookViewController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "searchSegue", sender: self)
		self.viewOutput?.bookWasSearched(with: indexPath.row)
	}
}

extension SearchBookViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if isFiltering() {
			return filteredBooks.count
		}
		return books.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = searchedBookCollectionView.dequeueReusableCell(withReuseIdentifier: "searchBook", for: indexPath) as? BookCell else {
			fatalError()
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
		
		cell.nameLabel.text = books[indexPath.row].name
		return cell
		
	}
}

extension SearchBookViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchController.searchBar.text!)
	}
}
