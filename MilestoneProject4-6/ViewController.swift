//
//  ViewController.swift
//  MilestoneProject4-6
//
//  Created by Harsh Verma on 05/08/21.
//

import UIKit

class ViewController: UIViewController {

    
    var table: UITableView!
    var shoppingList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBar))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBar))
        // Do any additional setup after loading the view.
    }

    func createTable() {
        table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ids")
        table.separatorStyle = .none
    }
    
    @objc func addBar() {
        let alert = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak alert] _ in
            guard let item = alert?.textFields?[0].text else {
                return
            }
            self?.addItem(item: item)
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func shareBar() {
        let list = shoppingList.joined(separator: "\n")
        let activity = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activity, animated: true, completion: nil)
    }
    
    func addItem(item: String) {
        shoppingList.insert(item, at: 0)
        let indexing = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexing], with: .automatic)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(table)
        table.frame = view.bounds
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ids", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
