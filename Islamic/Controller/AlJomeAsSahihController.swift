import UIKit
import SQLite3

class AlJomeAsSahihController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var chapters: [String] = []
    var heightLabel = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()

        chapters = database.fetch(name: "chapters", n: 1)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300

    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension AlJomeAsSahihController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomBookTableCell
        cell.titleCell.text = chapters[indexPath.row]
        if cell.titleCell.frame.height > 75 {
            heightLabel = cell.titleCell.frame.height
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
