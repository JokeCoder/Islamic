import UIKit
import Adhan

class CalendarViewController: UIViewController {
    
    @IBOutlet var calendarCollectionView: UICollectionView!
    @IBOutlet var headerLabelsCollection: [UILabel]!
    
    var today: Date?
    var date = Date()
    
    var days: DateComponents!
    var components: DateComponents!
    
    var calendar = Calendar.current
    
    var allFriday: [Int] = []
    var daysArr: [[String]] = []
    var prayerTimes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.today = date.startOfMonth
        
        let interval = calendar.dateInterval(of: .month, for: date)
        self.days = calendar.dateComponents([.day], from: interval!.start, to: interval!.end)
        
        self.components = Calendar.current.dateComponents([.day], from: date)
        self.createDateForCalendar()
        
        self.headerLabelsCollection[0].text = "Сана"
        self.headerLabelsCollection[1].text = "Бомдод"
        self.headerLabelsCollection[2].text = "Пешин"
        self.headerLabelsCollection[3].text = "Аср"
        self.headerLabelsCollection[4].text = "Шом"
        self.headerLabelsCollection[5].text = "Хуфтон"
    }
    
    @IBAction func popCalendarViewController(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func createDateForCalendar() {
        
        for i in 0..<days.day! {
            
            if today!.isFriday() {
                allFriday.append(i)
            } else {
                allFriday.append(-1)
            }
            
            createPrayerTimesForCalendar()
            
            var arr: [String] = []
            arr.append("\(i + 1) \(Date().month)")
            arr.append(prayerTimes[0])
            arr.append(prayerTimes[2])
            arr.append(prayerTimes[3])
            arr.append(prayerTimes[4])
            arr.append(prayerTimes[5])
            daysArr.append(arr)
            
            prayerTimes = []
        }
    }
    
    func createPrayerTimesForCalendar() {
        var dateComponents = DateComponents()
        dateComponents.setValue(1, for: .day)
        let tomorrow = calendar.date(byAdding: dateComponents, to: self.today!)
        today = tomorrow
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
        }
    }
}


extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return days.day!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCollectionViewCell", for: indexPath) as! CalendarCustomCell
        
        if indexPath.section == allFriday[indexPath.section] {
            cell.backgroundColor = .systemBlue
        } else if indexPath.section == components.day! - 1 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .white
        }
        
        cell.numLabel.text = String(self.daysArr[indexPath.section][indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 6
        return CGSize(width: width, height: width/2)
    }
    
}
