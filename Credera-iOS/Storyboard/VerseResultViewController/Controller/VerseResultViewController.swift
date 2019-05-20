//
//  VerseResultViewController.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import UIKit
import CoreData

class VerseResultViewController: UIViewController, NavigationHelper {
    
    public class var storyboardName: String { return "VerseResult" }
    public class var viewControllerID: String { return "VerseResultViewController" }

    @IBOutlet weak var verseTextLabel: UILabel!
    @IBOutlet weak var addVerseButton: UIButton!
    
    var verseDTO: VerseDTO?
    weak var delegate: NavigationCompletedProtocol?
    
    var bibleVerse: BibleVerseMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set title
        self.title = self.verseDTO?.reference
        
        // Hide button initially
        addVerseButton.isHidden = true

        // Setup API call
        let bibleApi: BibleApi = BibleApiImpl(caller: RequestCaller())
        let bibleService: BibleService = BibleServiceImpl(bibleApi: bibleApi)
        
        // Get verse details
        bibleService.getVerse(verseId: self.verseDTO?.verseId ?? "").then { (verse) in
            // Set label
            self.verseTextLabel.text = verse.text
            // Populate DTO
            self.verseDTO?.verseText = verse.text
            // Show button
            self.addVerseButton.isHidden = false
        }.catch { (error) in
            print(error)
        }
    }
    
    func setupUI() {
        // Set button styling
        addVerseButton.backgroundColor = UIColor(red: 13, green: 71, blue: 161)
        addVerseButton.tintColor = UIColor.white
        addVerseButton.layer.cornerRadius = 3
    }
    
    @IBAction func addVerse(_ sender: Any) {
        // Add verse to Core Data
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            self.bibleVerse = BibleVerseMO(context: appDelegate.persistentContainer.viewContext)
            self.bibleVerse.reference = self.verseDTO?.reference
            self.bibleVerse.text = self.verseDTO?.verseText
            self.bibleVerse.sortOrder = Int32(self.verseDTO?.bookNumber ?? 0)
            appDelegate.saveContext()
        }
        
        // Navigate back to the root view controller
        navigationController?.popToRootViewController(animated: true)
    }
    
    public static func getInstance(verseDTO: VerseDTO, delegate: NavigationCompletedProtocol) -> UIViewController {
        guard let verseResultViewController = getInstance() as? VerseResultViewController else {
            return UIViewController()
        }
        verseResultViewController.verseDTO = verseDTO
        verseResultViewController.delegate = delegate
        return verseResultViewController
    }

}

extension VerseResultViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {}
}
