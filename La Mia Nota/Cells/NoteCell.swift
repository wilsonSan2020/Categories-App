//
//  NoteCell.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/3/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import UIKit

class NoteCell : UITableViewCell {
    
    var noteData : Note! {
        didSet {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            
            noteTitle.text = noteData.title
            dateLabel.text = dateFormatter.string(from: noteData.date ?? Date())
            previewLabel.text = noteData.text
        }
    }
    
    fileprivate var noteTitle : UILabel = {
        let label = UILabel()
        label.text = "Places to take photos"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .superWhiteColor
        return label
        
    }()
    
    fileprivate var dateLabel : UILabel = {
        let label = UILabel()
        label.text = "01/03/20"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = .lessYellowColor
        return label
        
    }()
    
    fileprivate var previewLabel : UILabel = {
        let label = UILabel()
        label.text = "preview text"
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor.gray.withAlphaComponent(0.8)
        return label
        
    }()
    
    //use lazy so the stack iew will work
    fileprivate lazy var horizontalStackView : UIStackView = {
        let s = UIStackView(arrangedSubviews: [dateLabel, previewLabel])
        s.axis = .horizontal
        s.spacing = 10
        s.alignment = .leading
        return s
    }()
    
    fileprivate lazy var verticalStack : UIStackView = {
        let s = UIStackView(arrangedSubviews: [noteTitle, horizontalStackView])
        s.axis = .vertical
        s.spacing = 4
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    //date label
    
    //preview label
    
    //horizontal stack view
    
    //vertical stack view
    
 
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(verticalStack)
        
        verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        //verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        //verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        verticalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
