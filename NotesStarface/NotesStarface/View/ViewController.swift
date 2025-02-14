//
//  ViewController.swift
//  NotesStarface
//
//  Created by Johanna Reiting on 14.02.25.
//

import UIKit

class ViewController: UITableViewController, NotesViewModelDelegate {
    
    var viewModel: NotesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel = ViewModelImpl(delegate: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    // 'required' initializer 'init(coder:)' must be provided by subclass of
    // 'UITableViewController'; this is an error in the Swift 6 language mode
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

