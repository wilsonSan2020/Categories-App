//
//  FolderCell.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/3/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

class FolderCell : UITableViewCell {
    
    var folderData : NoteFolder! {
        didSet {
            label.text = folderData.title
            let count = CoreDataManager.shared.fetchNotes(from: folderData).count
            countLabel.text = String(count)
        }
    }
    
    fileprivate var label : UILabel = {
        let label = UILabel()
        label.text = "Folder Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .superWhiteColor
        
        return label
    }()
    
    fileprivate var countLabel : UILabel = {
        let label = UILabel()
        label.text = "200"
        label.textColor = .superYellowColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .light) //when the text was 16, device was showing errounous label alignment
        
        return label
    }()
    
    //lazy compiles after everything else, for the stack to use
    fileprivate lazy var stack : UIStackView = {
        let s = UIStackView(arrangedSubviews: [label, countLabel])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.distribution = .equalSpacing
        s.alignment = .fill
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.accessoryType = .disclosureIndicator
       
        
        
        contentView.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
