//
//  ViewController.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import SwiftUI
import CoreData

@main
struct NotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "NotesStarface")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

struct MainView: View {
    @StateObject var viewModel = NotesViewModelImpl(context: PersistenceController.shared.container.viewContext)
    @State var notes: [NoteEntity]?
    @State private var searchText = ""
    @State private var selectedNote: NoteEntity? // State for managing navigation
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(notes ?? []) { note in
                        NoteCellView(viewModel: _viewModel, note: $selectedNote)
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText, placement: .toolbar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: DetailView(viewModel: _viewModel, note: nil)) {
                        Text("Add")
                    }
                }
            }
        }
    }
}

struct NoteCellView: View {
    let viewModel: StateObject<NotesViewModelImpl>
    @Binding var note: NoteEntity? // Bind to the selected note
    
    var body: some View {
        NavigationLink(destination: DetailView(viewModel: viewModel, note: note)) {
            VStack {
                Text(note?.title ?? "")
                    .font(.headline)
                    .lineLimit(1)
                Text(note?.content ?? "")
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

