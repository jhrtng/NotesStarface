//
//  DetailViewController.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 15.02.25.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    var viewModel: NotesViewModel!
    var note: NoteEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem?.title = "Save" // TODO: doesn't work yet
        
        // if editing, note is not nil
        // note is nill if creating new note
        if let note = note {
            titleTextView.text = note.title
            contentTextView.text = note.content
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        guard titleTextView.text != "" else {
            showAlert("Please enter both a title and content.")
            return
        }
        
        viewModel.saveNote(title: titleTextView.text!, content: contentTextView.text, note: note)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
