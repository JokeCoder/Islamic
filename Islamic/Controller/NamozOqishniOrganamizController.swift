//
//  NamozOqishniOrganamizController.swift
//  Muslim UZ
//
//  Created by Asliddin Rasulov on 14/10/20.
//

import UIKit

class NamozOqishniOrganamizController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let names = ["Таҳорат олиш тартиби", "Азон", "Бомдод намози", "Пешин намози", "Аср намози", "Шом намози", "Хуфтон намози"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = view.frame.height / 10
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension NamozOqishniOrganamizController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.numLabel.text = "\(indexPath.row + 1)"
        cell.descriptionLabel.text = names[indexPath.row]
        return cell
    }
    
    
}
