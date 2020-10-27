//
//  Al-Jome_As-SahihController.swift
//  Muslim UZ
//
//  Created by Asliddin Rasulov on 9/10/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit
import SQLite3

class Al_Jome_As_Sahih_Controller: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var chapters: [String] = []
    var heightLabel = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chapters = fetch(name: "chapters", n: 1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension Al_Jome_As_Sahih_Controller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Al_Jome_As_Sahih_Cell
        cell.chaptersLabel.text = chapters[indexPath.row]
        if cell.chaptersLabel.frame.height > 75 {
            heightLabel = cell.chaptersLabel.frame.height
        }
        return cell
    }
}
