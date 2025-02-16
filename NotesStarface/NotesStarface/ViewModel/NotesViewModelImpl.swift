//
//  NotesViewModelImpl.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

import Foundation

class NotesViewModelImpl: NotesViewModel {
    var delegate: NotesViewModelDelegate?
    var noteManager: NoteManagerImpl!
    var notes: [NoteEntity]?
    
    init(delegate: NotesViewModelDelegate, context: NSManagedObjectContext) {
        self.delegate = delegate
        noteManager = NoteManagerImpl(context: context)
    }
    
    // NotesViewModel
    
    func fetchAllNotes() -> [NoteEntity] {
        notes = noteManager.fetchAllNotes()
        return notes ?? []
    }
    
    func saveNote(title: String, content: String, note: NoteEntity?) {
        if let existingNote = note {
            // Edit existing note
            existingNote.title = title
            existingNote.content = content
            existingNote.timestamp = Date()
        } else {
            // Create a new note
            noteManager.createNote(withTitle: title, content: content)
        }

        // update notes
        notes = noteManager.fetchAllNotes()
        delegate?.notesDidUpdate(notes: notes ?? [])
    }
    
    func deleteNote(note: NoteEntity) {
        noteManager.deleteNote(note)
        notes = noteManager.fetchAllNotes()
        delegate?.notesDidUpdate(notes: notes ?? [])
    }
    
    func searchForNotes(with text: String) {
        let filteredNotes = notes?.filter { note in
            note.title?.localizedCaseInsensitiveContains(text) ?? false ||
            note.content?.localizedCaseInsensitiveContains(text) ?? false
        }
        
        delegate?.notesDidUpdate(notes: filteredNotes ?? [])
    }
    
}
