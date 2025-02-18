//
//  DetailViewController.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var titleText: String
    @State private var contentText: String
    @State private var showAlert = false
    
    @StateObject var viewModel: NotesViewModelImpl
    var note: NoteEntity?
    
    init(viewModel: StateObject<NotesViewModelImpl>, note: NoteEntity?) {
        _viewModel = viewModel
        self.note = note
        _titleText = State(initialValue: note?.title ?? "")
        _contentText = State(initialValue: note?.content ?? "")
    }

    var body: some View {
        VStack {
            TextField("Title", text: $titleText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextEditor(text: $contentText)
                .frame(height: 200)
                .border(Color.gray, width: 0.5)
                .padding()

            Spacer()
        }
        .navigationTitle(note == nil ? "New Note" : "Edit Note")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveNote()
                }
            }
        }
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter a title.")
        }
    }

    private func saveNote() {
        guard !titleText.isEmpty else {
            showAlert = true
            return
        }

        viewModel.saveNote(title: titleText, content: contentText, note: note)
        presentationMode.wrappedValue.dismiss()
    }
}
