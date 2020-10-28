import UIKit

class NamozOqishniOrganamizController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let names = ["tahorat_olish", "azon", "bomdod_namozi", "peshin_namozi", "asr_namozi", "shom_namozi", "xufton_namozi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = view.frame.height / 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "learnPrayer" {
            let vc = segue.destination as! WebViewController
            vc.rowName = names[tableView.indexPathForSelectedRow!.row]
        }
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
