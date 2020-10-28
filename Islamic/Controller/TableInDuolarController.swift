//
//  TableinDuolarController.swift
//  Islamic
//
//  Created by Asliddin Rasulov on 27/10/20.
//

import UIKit

class TableInDuolarController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var database = Database()
    
    var rowName: String = ""
    var duoArray: [[String]] = []
    var rowArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = rowName
        tableView.rowHeight = view.frame.height / 10

        for i in 1...3 {
            duoArray.append(database.fetch(name: "duas", n: i))
        }
        
        for i in duoArray[2].indices {
            if "duo\(duoArray[2][i])" == rowName {
                rowArray.append(duoArray[0][i])
            }
        }
        if rowArray.isEmpty {
            rowArray = duoArray[0]
        }
    }
        
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TableInDuolarController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.numLabel.text = "\(indexPath.row + 1)"
        cell.descriptionLabel.text = rowArray[indexPath.row]
        return cell
    }
    
    
}
