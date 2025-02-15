//
//  NotesViewModelDelegate.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import Foundation

protocol NotesViewModelDelegate {
    func notesDidUpdate(notes: [NoteEntity])
}
