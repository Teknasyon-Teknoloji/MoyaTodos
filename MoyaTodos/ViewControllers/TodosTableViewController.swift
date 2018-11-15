//
//  TodosTableViewController.swift
//  MoyaTodos
//
//  Created by Omar on 11/15/18.
//  Copyright © 2018 Teknasyon. All rights reserved.
//

import UIKit

final class TodosTableViewController: UITableViewController {

	private let cellIdentifier = "TodoCell"

	private var todos: [Todo] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		fetchTodos()
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
		let todo = todos[indexPath.row]
		return configureCell(cell, for: todo)
    }

	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
			self.deleteTodo(at: indexPath)
		}
		return [deleteAction]
	}

}

// MARK: - Networking
private extension TodosTableViewController {

	func fetchTodos() {
		API.todosProvider.request(.getAll) { [weak self] result in
			switch result {
			case .failure(let error):
				print(error.localizedDescription)

			case .success(let response):
				guard let todos = try? response.map([Todo].self) else { return }
				self?.loadTodos(todos)
			}
		}
	}

	func deleteTodo(at indexPath: IndexPath) {
		let todo = todos[indexPath.row]
		API.todosProvider.request(TodosService.delete(id: todo.id)) { [weak self] result in
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success:
				self?.clearTodo(atIndexPath: indexPath)
			}
		}
	}

}

// MARK: - Helpers
private extension TodosTableViewController {

	func configureCell(_ cell: UITableViewCell, for todo: Todo) -> UITableViewCell {
		cell.textLabel?.text = todo.title
		cell.detailTextLabel?.text = todo.completed ? "Completed" : nil
		return cell
	}

	func loadTodos(_ todos: [Todo]) {
		self.todos = todos
		tableView.reloadData()
	}

	func clearTodo(atIndexPath indexPath: IndexPath) {
		todos.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .automatic)
	}


}
