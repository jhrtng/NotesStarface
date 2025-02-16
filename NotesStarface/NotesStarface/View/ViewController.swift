//
//  ViewController.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import UIKit

class ViewController: UITableViewController, NotesViewModelDelegate {
    var viewModel: NotesViewModel!
    var notes: [NoteEntity]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // button to add new note
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateNewNote))
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewModel = NotesViewModelImpl(delegate: self, context: context)
        viewModel.fetchAllNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell
        cell.titleLabel.text = note?.title
        cell.contentPreviewLabel.text = note?.content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let note = notes?[indexPath.row] else {
            return
        }
        
        if editingStyle == .delete {
            viewModel.deleteNote(note: note)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // disable the search bar's cursor
        searchBar.resignFirstResponder()
        performSegue(withIdentifier: "showDetailViewController", sender: indexPath)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // disable the search bar's cursor
        searchBar.resignFirstResponder()
    }
    
    @IBAction func didTapCreateNewNote(_ sender: Any) {
        performSegue(withIdentifier: "createNewNote", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailViewController" {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            
            detailViewController.viewModel = viewModel // should maybe be separate ViewModel
            detailViewController.note = notes?[indexPath.row]
        } else if segue.identifier == "createNewNote" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.viewModel = viewModel // should maybe be separate ViewModel
        }
    }
    
    // NotesViewModelDelegate
    
    func notesDidUpdate(notes: [NoteEntity]) {
        self.notes = notes
        tableView.reloadData()
    }
    
    // 'required' initializer 'init(coder:)' must be provided by subclass of
    // 'UITableViewController'; this is an error in the Swift 6 language mode
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.fetchAllNotes()
            return
        }
        
        viewModel.searchForNotes(with: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // show cursor on user interaction
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        viewModel.searchForNotes(with: searchText)
        searchBar.resignFirstResponder()
    }
}

