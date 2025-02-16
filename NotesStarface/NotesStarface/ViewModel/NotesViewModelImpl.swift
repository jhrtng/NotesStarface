//
//  NotesViewModelImpl.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

import Foundation

class NotesViewModelImpl: NotesViewModel {
    weak var delegate: NotesViewModelDelegate?
    var noteManager: NoteManager?
    var notes: [NoteEntity]?
    
    init(delegate: NotesViewModelDelegate, context: NSManagedObjectContext) {
        self.delegate = delegate
        noteManager = NoteManagerImpl(context: context)
    }
    
    // NotesViewModel
    
    func fetchAllNotes() {
        notes = noteManager?.fetchAllNotes()
        delegate?.notesDidUpdate(notes: notes ?? [])
    }
    
    func saveNote(title: String, content: String, note: NoteEntity?) {
        if let existingNote = note {
            // Edit existing note
            noteManager?.editNote(existingNote, withTitle: title, andContent: content)
        } else {
            // Create a new note
            noteManager?.createNote(withTitle: title, content: content)
        }

        // update notes
        notes = noteManager?.fetchAllNotes()
        delegate?.notesDidUpdate(notes: notes ?? [])
    }
    
    func deleteNote(note: NoteEntity) {
        noteManager?.deleteNote(note)
        notes = noteManager?.fetchAllNotes()
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
