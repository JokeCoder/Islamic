//
//  TableInIslomViewController.swift
//  Islamic
//
//  Created by coder on 05/11/20.
//

import UIKit

class TableInIslomViewController: UIViewController {
    var db = Database()
    
    var arrayInIslam: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayInIslam = db.fetch(name: title!, n: 1)
        // Do any additional setup after loading the view.
    }
}

extension TableInIslomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInIslam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.numLabel.text = "\(indexPath.row + 1)"
        cell.descriptionLabel.text = arrayInIslam[indexPath.row]
        return cell
    }
    
    
}
