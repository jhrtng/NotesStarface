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
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.notes ?? []) { note in
                        NoteCellView(viewModel: _viewModel, note: note)
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
    var note: NoteEntity?
    
    var body: some View {
        NavigationLink(destination: DetailView(viewModel: viewModel, note: note)) {
            VStack {
                Text(note?.title ?? "")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Text(note?.content ?? "")
                    .font(.none)
                    .frame(maxWidth: .infinity, alignment: .leading)
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

