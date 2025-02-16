//
//  NotesViewModelImpl.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

import Foundation

class NotesViewModelImpl: ObservableObject {
    var noteManager: NoteManager?
    @Published var notes: [NoteEntity]?
    
    init(context: NSManagedObjectContext) {
        noteManager = NoteManagerImpl(context: context)
    }
    
    // NotesViewModel
    
    func fetchAllNotes() {
        notes = noteManager?.fetchAllNotes()
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
    }
    
    func deleteNote(note: NoteEntity) {
        noteManager?.deleteNote(note)
        notes = noteManager?.fetchAllNotes()
    }
    
    func searchForNotes(with text: String) {
        notes = notes?.filter { note in
            note.title?.localizedCaseInsensitiveContains(text) ?? false ||
            note.content?.localizedCaseInsensitiveContains(text) ?? false
        }
    }
    
}
