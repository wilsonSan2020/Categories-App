//
//  ViewController.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/3/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

//
//    let firstFolderNotes = [
//        Note(title: "UITableView", date: Date(), text: "tableViews use protocols to receive data"),
//        Note(title: "CollectionView", date: Date(), text: "can be customize like pinterest"),
//        Note(title: "Flow Layouts", date: Date(), text: "gtreat layouts")
//
//    ]
//
//    let secondFolderNotes = [
//        Note(title: "Cars", date: Date(), text: "premiun cras available"),
//        Note(title: "Pools", date: Date(), text: "olympic style"),
//        Note(title: "Big House", date: Date(), text: "across Connecticut, nice massive homes")
//
//    ]
//
//    var noteFolders : [NoteFolder] = [
//        NoteFolder(title: "Course Notes", notes: firstFolderNotes),
//        NoteFolder(title: "Social Media", notes: secondFolderNotes)
//        ]

//tableView extensions
extension FoldersController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteFolders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! FolderCell
        let folderForRow = noteFolders[indexPath.row]
        cell.folderData = folderForRow
        
        //color changed*******
        
        cell.backgroundColor = .darkMatter
        let backgroundView = UIView()
        backgroundView.backgroundColor = .noteDetailBackgroundColor
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let folderNotesController = FolderNotesController()
        let folderForRowSelected = noteFolders[indexPath.row]
        folderNotesController.folderData = folderForRowSelected
        //use instance
        navigationController?.pushViewController(folderNotesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
       {
           //var actions = [UIContextualAction]()
           
           print(">>> Trying to swipe row \(indexPath.row)")
           let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
               print(">>> 'Delete' clicked on \(indexPath.row)")
            let noteFolder = noteFolders[indexPath.row]
            if CoreDataManager.shared.deleteNoteFolder(noteFolder: noteFolder) {
                noteFolders.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }

               //tableView.deleteRows(at: [indexPath], with: .fade)
           }
           
           let actions = UISwipeActionsConfiguration(actions: [deleteAction])
           return actions
           
       }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //cell.backgroundColor = .darkMatter
    }

}

var noteFolders = [NoteFolder]()

//FoldersController
class FoldersController: UITableViewController {
    
    fileprivate let CELL_ID : String = "CELL_ID"
    //for the header view
    fileprivate let headerView : UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 20, y: 15, width: 200, height: 20))
        label.text = "CORE DATA FRAMEWORK"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .greenLightColor
        label.alpha = 0.50
        headerView.addBorder(toSide: .bottom, withColor: UIColor.white.withAlphaComponent(0.15).cgColor, andThickness: 0.3) //was superlightgray
        headerView.addSubview(label)
        return headerView
    }()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .superLightGrayColor
        //navigationItem.title = "Mia Notas"
        
        configureNavigationBar(largeTitleColor: .superLightBlueColor, backgoundColor: .darkMatter, tintColor: .superWhiteColor, title: "Categories", preferredLargeTitle: true)

       
        
        //noteFolders = CoreDataManager.shared.fe
        noteFolders = CoreDataManager.shared.fetchNoteFolders()
        tableView.backgroundColor = .darkMatter

        //self.tableView.backgroundView?.backgroundColor = .darkMatter
        
        setupTableView()

    }
 
    fileprivate func setupTableView() {
        
        tableView.register(FolderCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.tableHeaderView = headerView
    }
    
    fileprivate func setupTranslucentViews() {
        let toolBar = self.navigationController?.toolbar
        let navigationBar = self.navigationController?.navigationBar
        let slightWhite = getImage(withColor: UIColor.darkMatter.withAlphaComponent(0.9), andSize: CGSize (width: 30, height: 30)) //color was white
        
        
        navigationBar?.setBackgroundImage(slightWhite, for: .default)
        navigationBar?.shadowImage = slightWhite
        
        
        toolBar?.setBackgroundImage(slightWhite, forToolbarPosition: .any, barMetrics: .default)
        //get rid of the lines:
        toolBar?.setShadowImage(UIImage(), forToolbarPosition: .any)
    }
    
    ///COMPLEX
    fileprivate func getImage(withColor color: UIColor, andSize size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController?.setToolbarHidden(false, animated: false)
        
        let items : [UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "New Category", style: .done, target: self, action: #selector(self.handleAddNewFolder))
            
        ]
        
        self.toolbarItems = items
        
        /*
        //adding the edit button on the top right of the navigation bar
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
   */
        //self.navigationItem.setRightBarButtonItems([editButton], animated: false)//if using more button items use the array
        //self.navigationItem.setRightBarButton(editButton, animated: false)
        self.navigationController?.toolbar.tintColor = .superLightPurpleColor
        self.navigationController?.navigationBar.tintColor = .superLightPurpleColor
      
        setupTranslucentViews()
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool {
        <#code#>
    }
    
    var textField:UITextField!
    
    @objc fileprivate func handleAddNewFolder() {
        let addAlert = UIAlertController(title: "New Category", message: "Enter a name for this category", preferredStyle: .alert)
        
        addAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) in
            addAlert.dismiss(animated: true)
        }))
        
        addAlert.addTextField { (tf) in
            //referenced textfield  outside of this method
            self.textField = tf
        }
        
        addAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            
            addAlert.dismiss(animated: true)
            
            guard let title = self.textField.text else {return}
            print(title)

            let newFolder = CoreDataManager.shared.createNoteFolder(title: title)
            noteFolders.append(newFolder)
            self.tableView.insertRows(at: [IndexPath(row: noteFolders.count - 1, section: 0)], with: .fade)
            
            
            
        }))
        
        present(addAlert, animated: true)
    }
    
    

}

extension UIViewController {
func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title

    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = backgoundColor
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
}}


