import UIKit

class Asmaul_Husna_Cell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
