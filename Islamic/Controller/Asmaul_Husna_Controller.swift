import UIKit
import SQLite3

class Asmaul_Husna_Controller: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = []
    var info: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        names = fetch(name: "names", n: 1)
//        info = fetch(name: "names", n: 2)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension Asmaul_Husna_Controller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Asmaul_Husna_Cell
        cell.idLabel.text = "\(indexPath.row + 1)"
        cell.namesLabel.text = names[indexPath.row]
        cell.infoLabel.text = info[indexPath.row]
        return cell
    }
}
