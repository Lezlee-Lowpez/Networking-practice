//
//  UsersViewController.swift
//  DMNetworkingIntro
//
//  Created by David Ruvinskiy on 4/10/23.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource /*NetworkManagerDelegate */{
    

    var users : [User] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //Protocol func from networkManagerDelegate
//    func usersRetrieved(_ users: [User]) {
//        self.users = users
//        tableView.reloadData()
//    }
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Set up the resuable cell from Constants file
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userReuseID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let user = users[indexPath.row]
        
        content.text = user.firstName
        content.secondaryText = user.email
        
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    func configureTableView () {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.userReuseID)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
//        NetworkManager.shared.delegate = self
        getUsers()
    }
    
    /**
   Call the `NetworkManager`'s `getUsers` function. In the `usersRetrieved` function, assign the `users` property to the array we got back from the API and call `reloadData` on the table view.
     */
    
    
    func getUsers() {
        // Call the getUsers method on the NetworkManager singleton.
        NetworkManager.shared.getUsers {  result in
            // Since we're updating the UI, we need to make sure these updates happen on the main thread.
            DispatchQueue.main.async {
                // Handle the result of the network request.
                switch result {
                case .success(let users):
                    // If the network request was successful, we get an array of users.
                    self.users = users
                    // Reload the tableView to display the new data.
                    self.tableView.reloadData()
                case .failure(let error):
                    // If the network request failed, we get an error.
                    // Call the presentError function to show an error alert to the user.
                    self.presentError(error)
                }
            }
        }
    }
    
    
    func presentError(_ error: DMError) {
        // Create an alert controller to show the error message.
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        // Add an 'OK' action to the alert controller.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // Present the alert controller.
        self.present(alert, animated: true)
    }
}
