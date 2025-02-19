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
        
        // button for saving note
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        
        // if editing, note is not nil
        // if creating new note, note is nil
        if let note = note {
            titleTextView.text = note.title
            contentTextView.text = note.content
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        guard titleTextView.text != "" else {
            showAlert("Please enter a title.")
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
