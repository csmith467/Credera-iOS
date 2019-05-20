//
//  VerseViewController.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import UIKit

class VerseViewController: UIViewController, NavigationHelper, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public class var storyboardName: String { return "Verse" }
    public class var viewControllerID: String { return "VerseViewController" }
    
    var verseDTO: VerseDTO?
    weak var delegate: NavigationCompletedProtocol?
    
    var verses: [Verse] = [Verse]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Setup API call
        let bibleApi: BibleApi = BibleApiImpl(caller: RequestCaller())
        let bibleService: BibleService = BibleServiceImpl(bibleApi: bibleApi)
        
        // Get list of verses
        bibleService.getVerses(chapterId: verseDTO?.chapterId ?? "").then { (verses) in
            // Assign data to chapters array
            self.verses = verses
            // Reload the collection view
            self.collectionView.reloadData()
            }.catch { (error) in
                print(error)
        }
    }
    
    func setupUI() {
        // Set title
        self.title = self.verseDTO?.reference
        
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
        guard let verseViewController = getInstance() as? VerseViewController else {
            return UIViewController()
        }
        verseViewController.verseDTO = verseDTO
        verseViewController.delegate = delegate
        return verseViewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return verses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerseCell", for: indexPath) as? VerseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.verseLabel.text = String(indexPath.row + 1)
        cell.backgroundColor = UIColor.white
        cell.verseLabel.textColor = UIColor.darkGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Populate DTO with more data
        if let book = self.verseDTO?.bookName, let chapter = self.verseDTO?.chapterNumber {
            verseDTO?.reference = book + " " + chapter + ":" + String(indexPath.row + 1)
        }
        verseDTO?.verseId = verses[indexPath.row].id
        
        // Navigate to the verse result screen
        let verseResultScreen = VerseResultViewController.getInstance(verseDTO: verseDTO ?? VerseDTO(), delegate: self)
        navigationController?.pushViewController(verseResultScreen, animated: true)
    }
    
}

extension VerseViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {}
}
