//
//  NotesViewModelDelegate.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import Foundation

protocol NotesViewModelDelegate: AnyObject {
    var viewModel: NotesViewModel! { get }
    var notes: [NoteEntity]? { get }
    func notesDidUpdate(notes: [NoteEntity])
}
