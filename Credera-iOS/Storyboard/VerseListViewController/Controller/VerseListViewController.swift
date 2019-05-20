//
//  VerseListViewController.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import UIKit
import CoreData

class VerseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var bibleVerses: [BibleVerseMO] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var emptyTableView: UIView!
    
    var fetchResultController: NSFetchedResultsController<BibleVerseMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the UI
        setupUI()
        
        // Fetch saved data
        let fetchRequest: NSFetchRequest<BibleVerseMO> = BibleVerseMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "sortOrder", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    bibleVerses = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Make status bar white
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Deselect all rows in the table
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func setupUI() {
        // Assign empty background view to table
        tableView.backgroundView = emptyTableView
        tableView.backgroundView?.isHidden = true
        
        // Set nav bar properties
        navigationController?.navigationBar.barTintColor = UIColor(red: 13, green: 71, blue: 161)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if bibleVerses.count > 0 {
            // Hide background
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            // Show background
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bibleVerses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "VerseListCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VerseListTableViewCell {
            cell.verseLabel.text = bibleVerses[indexPath.row].reference
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completeHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let bibleVerseToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(bibleVerseToDelete)
                appDelegate.saveContext()
            }
            completeHandler(true)
        }
        deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
        deleteAction.image = UIImage(named: "delete")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let verseDetailScreen = VerseDetailViewController.getInstance(bibleVerse: bibleVerses[indexPath.row], delegate: self)
        navigationController?.pushViewController(verseDetailScreen, animated: true)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            if let newFetchedObjects = fetchedObjects as? [BibleVerseMO] {
                bibleVerses = newFetchedObjects
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension VerseListViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {}
}
