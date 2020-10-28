import UIKit

class ZikrlarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TongiVaTungiZikrlarController
        if segue.identifier == "tong" {
            vc.fetchName = "zikr_morning"
        } else {
            vc.fetchName = "zikr_evening"
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
