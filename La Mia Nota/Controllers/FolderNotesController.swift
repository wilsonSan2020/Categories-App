//
//  FolderNotesController.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/3/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

extension FolderNotesController : NoteDelegate {
    func saveNewNote(title: String, date: Date, text: String){
        let newNote = CoreDataManager.shared.createNewNote(title: title, date: date, text: text, noteFolder: self.folderData)
        notes.append(newNote)
        filteredNotes.append(newNote)
        self.tableView.insertRows(at: [IndexPath(row: notes.count - 1, section: 0)], with: .fade)
    }
}

class FolderNotesController : UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var folderData : NoteFolder! {
        didSet {
            //notes = folderData.notes
            notes = CoreDataManager.shared.fetchNotes(from: folderData)
            filteredNotes = notes
        }
    }
    
    fileprivate var notes = [Note]()
    fileprivate var filteredNotes = [Note]()
    
    fileprivate let CELL_ID : String = "CELL_ID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .darkMatter
        
        self.navigationItem.title = "Notes"
        
        
        
        setupTableView()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        
    }
    
    fileprivate func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let items : [UIBarButtonItem] = [
        
            //UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "\(notes.count) notes", style:  .done, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.createNewNote))
        ]
        
        self.toolbarItems = items
        
        tableView.reloadData()
        
    }
    
    @objc fileprivate func createNewNote() {
        let noteDetailController = NotaDetailController()
        noteDetailController.delegate = self
        navigationController?.pushViewController(noteDetailController, animated: true)
        
    }
    
    var cachedText : String = ""
    
}

extension FolderNotesController : UISearchBarDelegate {
    //filter data
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //print(searchText)
        
        filteredNotes = notes.filter({ (note) -> Bool in
            return note.title?.lowercased().contains(searchText.lowercased()) ?? false
        })
        if searchBar.text!.isEmpty && filteredNotes.isEmpty {
            filteredNotes = notes
        }
        cachedText = searchText
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !cachedText.isEmpty && !filteredNotes.isEmpty {
            searchController.searchBar.text = cachedText
        }
    }
    
 
    
}

extension FolderNotesController {
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //var actions = [UIContextualAction]()
        
        print(">>> Trying to swipe row \(indexPath.row)")
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print(">>> 'Delete' clicked on \(indexPath.row)")
            let targetRow = indexPath.row
            if CoreDataManager.shared.deleteNote(note: self.notes[targetRow]) {
                self.notes.remove(at: targetRow)
                self.filteredNotes.remove(at: targetRow)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
           
        }
        
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.filteredNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! NoteCell
        //cell.textLabel?.text = "here is a note"
        
        cell.backgroundColor = .darkMatter
        let backgroundView = UIView()
        backgroundView.backgroundColor = .noteDetailBackgroundColor
        cell.selectedBackgroundView = backgroundView
        
        let noteForRow = self.filteredNotes[indexPath.row]
        cell.noteData = noteForRow
        
        
        //let selectedRow = indexPath.row
        //self.navigationItem.title = "\(String(describing: notes[selectedRow].title))) Notes"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailController = NotaDetailController()
        let noteForRow = self.filteredNotes[indexPath.row]
        noteDetailController.noteData = noteForRow
        navigationController?.pushViewController(noteDetailController, animated: true)
        
   
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}


