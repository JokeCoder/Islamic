import UIKit
import Adhan
import CoreLocation

var lat: CLLocationDegrees?
var long: CLLocationDegrees?

var database = Database()

class BoshSahifaController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var prayerTimeLabel: UILabel!
    @IBOutlet weak var prayerNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var locationManager: CLLocationManager!
    
    var names = ["namoz vaqtlari", "duolar", "zikrlar", "aljome_as_sahih", "asmaul_husna", "islom", "qibla", "tasbeh", "olti_diniy_kalima", "makka_live", "radio", "you_tube"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentDate(date: Date(), type: "islamic")
        collectionViewHeightConstraint.constant = 1.28 * view.frame.width + 30
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.determineCurrentLocation()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func decreaseTimer() {
        if lat != nil {
            prayersTimes()
        }
    }
    
    func determineCurrentLocation() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        lat = manager.location?.coordinate.latitude
        long = manager.location?.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            let pm = placemarks![0] as CLPlacemark
            self.displayLocationInfo(placemark: pm)
        })
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        locationLabel.text = placemark.locality! + "  "
        prayersTimes()
    }
    
    @IBAction func notification(_ sender: UIButton) {
        if notificationLabel.text == "Ёқилган" {
            sender.setImage(UIImage(named: "notification_off"), for: .normal)
            notificationLabel.text = "Ўчирилган"
        } else {
            sender.setImage(UIImage(named: "notification_on"), for: .normal)
            notificationLabel.text = "Ёқилган"
        }
    }
    
    func prayersTimes() {
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: lat!, longitude: long!)
        var params = CalculationMethod.northAmerica.params
        params.madhab = .hanafi
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone.current
            prayer(prayers: prayers, formatter: formatter)
        }
        
    }
    
    func prayer(prayers: PrayerTimes, formatter: DateFormatter) {
        var currentPrayerTime = Date()
        
        if prayers.nextPrayer() == nil {
            currentPrayerTime = prayers.fajr
            currentPrayerTime = currentPrayerTime + 86400
            let difTime = Date(timeIntervalSinceReferenceDate: currentPrayerTime.timeIntervalSince(Date()))
            let leftTime = " (-" + "\(difTime)".split(separator: " ")[1] + ")"
            prayerNameLabel.text = namesPrayers(name: "fajr") + " \(leftTime)"
        } else {
            currentPrayerTime = prayers.time(for: prayers.nextPrayer()!)
            let difTime = Date(timeIntervalSinceReferenceDate: currentPrayerTime.timeIntervalSince(Date()))
            let leftTime = " (-" + "\(difTime)".split(separator: " ")[1] + ")"
            prayerNameLabel.text = namesPrayers(name: "\(prayers.nextPrayer().unsafelyUnwrapped)") + " \(leftTime)"
        }
        prayerTimeLabel.text = formatter.string(from: currentPrayerTime)
    }
    
    func namesPrayers(name: String) -> String {
        switch name {
        
        case "fajr": return "Бомдод"
        case "dhuhr": return "Пешин"
        case "asr": return "Аср"
        case "maghrib": return "Шом"
        case "isha": return "Хуфтон"
            
        default: return ""
        }
    }
}

extension BoshSahifaController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
        cell.iconTitle.text = names[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.3 * view.frame.width - 10, height: 0.32 * view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "\(indexPath.row)") ?? NamozVaqtlariController()
        navigationController?.show(vc, sender: nil)
    }
}
