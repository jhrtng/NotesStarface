//
//  NotesManagerDelegate.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

import Foundation

@objc protocol NotesManagerDelegate: NSObjectProtocol {
    func didFetchNotes(notes: [NoteEntity])
}
