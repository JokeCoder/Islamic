import UIKit
import Adhan

class NamozVaqtlariController: UIViewController {

    @IBOutlet weak var hijriLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var timeLabels: [UILabel]!
    @IBOutlet var nameLabels: [UILabel]!
    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var etcView: UIView!
    
    
    var prayerTimes: [String] = []
    var today: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        today = Date()
        
        headView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        etcView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        hijriLabel.text = currentDate(date: today!, type: "islamic")
        hijriLabel.font = UIFont(name: "Chalkboard SE", size: view.frame.height / 60)
        
        dateLabel.text = currentDate(date: today!, type: "gregorian")
        hijriLabel.font = UIFont(name: "Chalkboard SE", size: view.frame.height / 35)
        
        prayersTimes()
    }
    
    @IBAction func previous(_ sender: UIButton) {
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day)
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: today!)
        today = yesterday
        hijriLabel.text = currentDate(date: today!, type: "islamic")
        dateLabel.text = currentDate(date: today!, type: "gregorian")
        prayersTimes()
    }
    
    @IBAction func next(_ sender: UIButton) {
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day)
        let tomorrow = Calendar.current.date(byAdding: dateComponents, to: today!)
        today = tomorrow
        hijriLabel.text = currentDate(date: today!, type: "islamic")
        dateLabel.text = currentDate(date: today!, type: "gregorian")
        prayersTimes()
    }
    
    func prayersTimes() {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: today!)
        
        let coordinates = Coordinates(latitude: lat!, longitude: long!)
        var params = CalculationMethod.northAmerica.params
        params.madhab = .hanafi
        
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone.current
            
            prayerTimes = [formatter.string(from: prayers.fajr), formatter.string(from: prayers.sunrise), formatter.string(from: prayers.dhuhr), formatter.string(from: prayers.asr), formatter.string(from: prayers.maghrib), formatter.string(from: prayers.isha)]
            
            for i in 0...5 {
                timeLabels[i].text = prayerTimes[i]
                nameLabels[i].font = UIFont(name: "Chalkboard SE", size: view.frame.height / 40)
                timeLabels[i].font = UIFont(name: "Chalkboard SE", size: view.frame.height / 40)
            }
        }
        
    }
    
    @IBAction func calendarAction(_ sender: UIButton) {
        
        
    }
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

