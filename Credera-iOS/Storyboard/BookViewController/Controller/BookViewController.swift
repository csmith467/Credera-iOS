//
//  BookViewController.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit
import Promises

public protocol NavigationCompletedProtocol: class {
    func showNavigationCompleted()
}

class BookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NavigationHelper {
    
    public class var storyboardName: String { return "Book" }
    public class var viewControllerID: String { return "BookViewController" }
    
    weak var delegate: NavigationCompletedProtocol?
    
    var books: [Book] = [Book]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setupUI() {
        // Set navigation style properties
        navigationController?.navigationBar.barTintColor = UIColor(red: 13, green: 71, blue: 161)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // Set cell layout
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 60) / 5, height: (self.collectionView.frame.size.width - 60) / 5)
        }
    }
    
    func populateData() {
        // Setup API call
        let bibleApi: BibleApi = BibleApiImpl(caller: RequestCaller())
        let bibleService: BibleService = BibleServiceImpl(bibleApi: bibleApi)
        
        // Get list of books
        bibleService.getBooks().then { (books) in
            
            // Assign data to books array
            self.books = books
            
            // Reload the collection view
            self.collectionView.reloadData()
            
        }.catch { (error) in
            print(error)
        }
    }
    
    public static func getInstance(delegate: NavigationCompletedProtocol) -> UIViewController {
        guard let bookViewController = getInstance() as? BookViewController else {
            return UIViewController()
        }
        bookViewController.delegate = delegate
        return bookViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Set cell text
        cell.bookLabel.text = books[indexPath.row].abbreviation
        
        // Set cell styling
        cell.backgroundColor = UIColor.white
        cell.bookLabel.textColor = UIColor.darkGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Create DTO to pass data through the screens
        var verseDTO = VerseDTO()
        verseDTO.bookId = books[indexPath.row].id
        verseDTO.bookName = books[indexPath.row].name
        verseDTO.bookNumber = (indexPath.row + 1)
        
        // Navigate to the chapter screen
        let chapterScreen = ChapterViewController.getInstance(verseDTO: verseDTO, delegate: self)
        navigationController?.pushViewController(chapterScreen, animated: true)
    }
    
}

extension BookViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {}
}
