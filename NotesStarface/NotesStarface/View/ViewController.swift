//
//  ViewController.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: NotesViewModelImpl
    @State var notes: [NoteEntity]?
    @State private var searchText = ""
    
    init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let viewModel = NotesViewModelImpl(context: context)
        _viewModel = StateObject(wrappedValue: viewModel)
      }
    
    var body: some View {
        NavigationStack {
            VStack {
                // TODO: search bar
                List {
                    ForEach(notes ?? []) { note in
                        NoteCellView(note: note, viewModel: _viewModel)
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, placement: .toolbar)
        }
    }
}

struct NoteCellView: View {
    let note: NoteEntity
    let viewModel: StateObject<NotesViewModelImpl>
    
    var body: some View {
        NavigationLink(destination: DetailView(viewModel: viewModel, note: note)) {
            VStack {
                Text(note.title ?? "")
                    .font(.headline)
                    .lineLimit(1)
                Text(note.content ?? "")
                    .font(.none)
                    .lineLimit(1)
            }
            .padding(.vertical, 10)
        }
    }
}

extension NoteEntity: Identifiable {
    public var id: UUID {
        return noteID!
    }
}

