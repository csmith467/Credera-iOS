//
//  ChapterViewController.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController, NavigationHelper, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public class var storyboardName: String { return "Chapter" }
    public class var viewControllerID: String { return "ChapterViewController" }
    
    var verseDTO: VerseDTO?
    weak var delegate: NavigationCompletedProtocol?
    
    var chapters: [Chapter] = [Chapter]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Setup API call
        let bibleApi: BibleApi = BibleApiImpl(caller: RequestCaller())
        let bibleService: BibleService = BibleServiceImpl(bibleApi: bibleApi)

        // Get list of books
        bibleService.getChapters(bookId: verseDTO?.bookId ?? "").then { (chapters) in
            // Assign data to chapters array
            self.chapters = chapters.filter { $0.number != "intro"}
            // Reload the collection view
            self.collectionView.reloadData()
        }.catch { (error) in
            print(error)
        }
    }
    
    func setupUI() {
        // Set title
        self.title = self.verseDTO?.bookName
        
        // Set collection view layout
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 60) / 5, height: (self.collectionView.frame.size.width - 60) / 5)
        }
        
        // Set back button title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    public static func getInstance(verseDTO: VerseDTO, delegate: NavigationCompletedProtocol) -> UIViewController {
        guard let chapterViewController = getInstance() as? ChapterViewController else {
            return UIViewController()
        }
        chapterViewController.verseDTO = verseDTO
        chapterViewController.delegate = delegate
        return chapterViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCell", for: indexPath) as? ChapterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Set cell text
        cell.chapterLabel.text = chapters[indexPath.row].number
        
        // Set cell styling
        cell.backgroundColor = UIColor.white
        cell.chapterLabel.textColor = UIColor.darkGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Populate DTO with more data
        verseDTO?.chapterId = chapters[indexPath.row].id
        verseDTO?.chapterNumber = chapters[indexPath.row].number
        verseDTO?.reference = chapters[indexPath.row].reference
        
        // Navigate to the verse screen
        let verseScreen = VerseViewController.getInstance(verseDTO: verseDTO ?? VerseDTO(), delegate: self)
        navigationController?.pushViewController(verseScreen, animated: true)
    }
    
}

extension ChapterViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {}
}
