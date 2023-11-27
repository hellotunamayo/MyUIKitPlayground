//
//  UITableViewExample.swift
//  UIKitPlayground
//
//  Created by Minyoung Yoo on 11/27/23.
//

import UIKit

class UITableViewExample: UIViewController {
    
    let dataSource: [String] = [
        "Hello1",
        "Hello2",
        "Hello3",
        "Hello4",
        "Hello5"
    ]
    
    let tableView: UITableView = {
        let tv: UITableView = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.backgroundColor = UIColor.systemBackground
        
        setupUI()
    }
    
    private func setupUI() -> Void {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            self.tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
        ])
    }
}

extension UITableViewExample: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User tapped \(dataSource[indexPath.row]).")
    }
}

extension UITableViewExample: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.item]
        return cell
    }
}

#Preview {
    UITableViewExample()
}
