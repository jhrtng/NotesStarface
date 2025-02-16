//
//  NotesViewModel.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import Foundation

protocol NotesViewModel {
    var delegate: NotesViewModelDelegate? { get }
    var noteManager: NoteManager? { get }
    var notes: [NoteEntity]? { get set }
    func fetchAllNotes()
    func saveNote(title: String, content: String, note: NoteEntity?)
    func deleteNote(note: NoteEntity)
    func searchForNotes(with text: String)
}
