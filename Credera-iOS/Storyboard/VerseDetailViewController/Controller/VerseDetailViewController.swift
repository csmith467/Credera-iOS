//
//  VerseDetailViewController.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import UIKit

class VerseDetailViewController: UIViewController, NavigationHelper {
    
    public class var storyboardName: String { return "VerseDetail" }
    public class var viewControllerID: String { return "VerseDetailViewController" }

    @IBOutlet weak var verseTextLabel: UILabel!
    
    var bibleVerse: BibleVerseMO?
    weak var delegate: NavigationCompletedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = self.bibleVerse?.reference
        verseTextLabel.text = self.bibleVerse?.text
    }
    
    public static func getInstance(bibleVerse: BibleVerseMO, delegate: NavigationCompletedProtocol) -> UIViewController {
        guard let verseDetailViewController = getInstance() as? VerseDetailViewController else {
            return UIViewController()
        }
        verseDetailViewController.bibleVerse = bibleVerse
        verseDetailViewController.delegate = delegate
        
        return verseDetailViewController
    }
}

extension VerseDetailViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {}
}
