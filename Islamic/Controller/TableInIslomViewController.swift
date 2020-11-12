//
//  TableInIslomViewController.swift
//  Islamic
//
//  Created by coder on 05/11/20.
//

import UIKit

class TableInIslomViewController: UIViewController {
    var db = Database()
    var arrayInIslam: [String] = []
    
    var myControllers = [TextInPageController]()
    var contentArray: [String] = []
    
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle.text = title
        
        arrayInIslam = db.fetch(name: title!, n: 1)
        contentArray = db.fetch(name: title!, n: 2)
        
        for i in arrayInIslam.indices {
            let vc = TextInPageController(with: contentArray[i], with: arrayInIslam[i])
            myControllers.append(vc)
        }
    }
}


extension TableInIslomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInIslam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.numLabel.text = "\(indexPath.row + 1)"
        cell.descriptionLabel.text = arrayInIslam[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentPageVC(from: indexPath.row)
    }
    
    func presentPageVC(from: Int) {
        let first = myControllers[from]
        let vc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}


extension TableInIslomViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController as! TextInPageController), index > 0 else {
            return nil
        }
        
        let before = index - 1
        return myControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController as! TextInPageController), index < (myControllers.count - 1) else {
            return nil
        }
        
        let after = index + 1
        return myControllers[after]
    }
}
