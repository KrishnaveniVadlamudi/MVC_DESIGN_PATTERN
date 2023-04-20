//
//  ResultViewController.swift
//  APIParser
//
//  Created by Sunkara on 4/17/23.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var urlStr :String = ""
    var toDoListarray :[Todo]  = []
    @IBOutlet weak var todoListTableView : UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        APIManager.shared.getAllTodos(urlStr:  urlStr) { [weak self] (responseTodoListAry: [Todo]) in
            self?.toDoListarray =  responseTodoListAry
            self?.todoListTableView.reloadData()
        }
       
        
    }
    
    func setupUI() {
        todoListTableView.dataSource = self
        todoListTableView.delegate = self
        todoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for:indexPath)
        let todoItem = toDoListarray[indexPath.row]
        cell.textLabel?.text = todoItem.todo!
        if todoItem.completed! {
            cell.backgroundColor = .gray  }
        else {
            cell.backgroundColor = .green }
        
       // cell.textLabel?.text = "Item \(indexPath.row)"
        return cell
    }
}
