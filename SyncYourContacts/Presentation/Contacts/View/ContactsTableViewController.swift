//
//  ContactsTableViewController.swift
//  SyncYourContacts
//
//  Created by Mohamed Ramadan on 26/09/2021.
//

import UIKit
import ContactsUI
import Contacts

class ContactsTableViewController: UITableViewController {
        
    var viewModel: ContactsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contacts"
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeContacts), name: .CNContactStoreDidChange, object: nil)
        self.setupTableView()
        self.bind(to: viewModel)
    }

    // MARK: - Private Methods
    @objc func didChangeContacts() {
        self.viewModel.loadContacts()
    }
    
    private func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
    }
    
    private func bind(to viewModel: ContactsListViewModel) {
        viewModel.loadContacts()
        viewModel.contactsCompletionHandler = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.viewModel.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")

        if (cell != nil) {
            cell =  UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        // Configure the cell...
        let contact = self.viewModel.contacts[indexPath.row]
        cell!.textLabel?.text = contact.name
        cell!.detailTextLabel?.text = contact.mobileNumbers.joined(separator: ", ")
        
        return cell!
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
