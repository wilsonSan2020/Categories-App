//
//  NotaDetailController.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/3/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

protocol NoteDelegate {
    func saveNewNote(title: String, date: Date, text: String)
}

class NotaDetailController : UIViewController {
    
    let dateformatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a" //the a detects if is AM or PM
        return dateFormatter
    }()
     var noteData:Note! {
        didSet {
            let dateFormatter = DateFormatter()
            textView.text = noteData.title
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date())
            textView2.text = noteData.text
            
        }
    }
    
    var delegate: NoteDelegate?
    
    fileprivate var textView : UITextView = {
        
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.text = ""
        tf.isEditable = true
        tf.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        tf.textColor = .superLightBlueColor
        
        return tf
        
    }()
    
    fileprivate var textView2 : UITextView = {
           
           let tf2 = UITextView()
           tf2.translatesAutoresizingMaskIntoConstraints = false
           tf2.text = ""
           tf2.isEditable = true
           tf2.font = UIFont.systemFont(ofSize: 18, weight: .regular)
           
           return tf2
           
       }()
    
    fileprivate lazy var dateLabel: UILabel = {
        
           let dateFormatter = DateFormatter()
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 14, weight: .light)
           label.textColor = .red
           label.text = dateFormatter.string(from: Date())
           label.textAlignment = .center
           return label
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .noteDetailBackgroundColor
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.noteData == nil {
            delegate?.saveNewNote(title: textView.text, date: Date(), text: textView.text)
        }else {
            //update our note here
            guard let newText = self.textView.text else { return }
            CoreDataManager.shared.saveUpdateNote(note: self.noteData, newText: newText)
        }
        
    }
    
    fileprivate lazy var stack : CustomStackView = {
           let s = CustomStackView(arrangedSubviews: [dateLabel, textView, textView2])
           s.translatesAutoresizingMaskIntoConstraints = false
           s.axis = .vertical
           s.distribution = .equalSpacing
           s.alignment = .fill
          // s.backgroundColor = .noteDetailBackgroundColor
        s.backgroundColor = .red
           
           return s
       }()
 
 
    fileprivate func setupUI() {
        
        view.addSubview(dateLabel)
        view.addSubview(textView)
        view.addSubview(textView2)
        
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        //textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        textView2.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10).isActive = true
        //textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        textView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView2.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let items : [UIBarButtonItem] = [
            
            
            //UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),//for spacing only
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),//for spacing only
            //UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),//for spacing only
            
            //UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
            //UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),//for spacing only
            //UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil),
            //UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), //for spacing only
            //UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        ]
        
        self.toolbarItems = items
        
        let topItems:[UIBarButtonItem] = [
            UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        ]
        
        self.navigationItem.setRightBarButtonItems(topItems, animated: false)
    }
    
}


extension UIStackView {

    func addBackground(color: UIColor) {
        let subview = UIView(frame: bounds)
        subview.backgroundColor = .lessYellowColor
        subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subview, at: 0)
    }

}
