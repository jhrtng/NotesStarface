//
//  NotesViewModel.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import Foundation

protocol NotesViewModel {
    func fetchAllNotes() -> [NoteEntity]
    func saveNote(title: String, content: String, note: NoteEntity?)
    func deleteNote(note: NoteEntity)
    func searchForNotes(with text: String)
}
