//
//  TableInIslomViewController.swift
//  Islamic
//
//  Created by coder on 05/11/20.
//

import UIKit

class TableInIslomViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension TableInIslomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.descriptionLabel.text = "zxc"
        return cell
    }
    
    
}
