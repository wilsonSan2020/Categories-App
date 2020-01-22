//
//  CoreDataManager.swift
//  La Mia Nota
//
//  Created by Wilson Sanchez on 1/7/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistenceContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesiOSApp") //NotesiOSApp
        container.loadPersistentStores(completionHandler: {(NSPersistentStoreDescription, err) in
            if let err = err {
                fatalError("Loading of stores failed: \(err)")
            }
            
        })
        
        return container
    }()
    
    //1. create noteFolder
    func createNoteFolder(title: String) -> NoteFolder {
        let context = persistenceContainer.viewContext
        
        let newNoteFolder = NSEntityDescription.insertNewObject(forEntityName: "NoteFolder", into: context) as! NoteFolder
        
        newNoteFolder.title = title
        
        do{
            try context.save()
            return newNoteFolder
        }catch let err {
            print("Failed to save new note folder:" , err)
        }
        return newNoteFolder
    }
    
    //2.fetchNoteFolders
    
    func fetchNoteFolders() -> [NoteFolder] {
        let context = persistenceContainer.viewContext
        
        let fetcRequest = NSFetchRequest<NoteFolder>(entityName: "NoteFolder")
        
        do {//doing it
            let noteFolders = try context.fetch(fetcRequest)
            return noteFolders
            
        }catch let err { //handling it, if it fails
            print("failed to fetch more folders:",err)
            return []
            
        }
    }
    
    func deleteNoteFolder(noteFolder: NoteFolder) -> Bool {
        let context = persistenceContainer.viewContext
        
        context.delete(noteFolder)
        
        do {
            try context.save()
            return true
        }catch let err {
            print("error deleting note folder entity instance", err)
            return false
        }
    }
    
    //Note Functions
    
    func createNewNote(title: String, date: Date, text: String, noteFolder: NoteFolder) -> Note {
    
        let context = persistenceContainer.viewContext
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        newNote.title = title
        newNote.text = text
        newNote.date = date
        newNote.noteFolder = noteFolder
        
        do {
            try context.save()
            return newNote
        }catch let err {
            print("Failed to save new note", err)
            return newNote
        }
    
    }
    
    
    func fetchNotes(from noteFolder: NoteFolder) -> [Note] {
    guard let folderNotes = noteFolder.notes?.allObjects as? [Note] else {return [] }
    return folderNotes
    }
    
    
    func deleteNote(note: Note) -> Bool {
        let context = persistenceContainer.viewContext
        
        context.delete(note)
        
        do {
            try context.save()
            return true
        }catch let err {
            print("error deleting note folder entity instance", err)
            return false
        }
    }
    
    
    func saveUpdateNote(note: Note, newText: String) {
        
        let context = persistenceContainer.viewContext
        note.title = newText
        note.text = newText
        note.date = Date()
        
        do {
            try context.save()
        }catch let err {
            print("error saving/editing the note", err)
        }
    }
    
    
}
