//
//  TableinDuolarController.swift
//  Islamic
//
//  Created by Asliddin Rasulov on 27/10/20.
//

import UIKit

class TableInDuolarController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var myControllers = [TextInPageController]()
    
    var rowName: String = ""
    var duoArray: [[String]] = []
    var rowArray: [String] = []
    var contentArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = rowName
        tableView.rowHeight = view.frame.height / 10
        
        for i in 1...3 {
            duoArray.append(database.fetch(name: "duas", n: i))
        }
        
        for i in duoArray[2].indices {
            if "duo\(duoArray[2][i])" == rowName {
                rowArray.append(duoArray[0][i])
            }
        }
        
        if rowArray.isEmpty {
            rowArray = duoArray[0]
        }
        
       
        for i in duoArray[2].indices {
            if "duo\(duoArray[2][i])" == rowName {
                contentArray.append(duoArray[1][i])
            }
            
        }
        
        if contentArray.isEmpty {
            contentArray = duoArray[1]
        }
        
        for i in rowArray.indices {
            let vc = TextInPageController(with: contentArray[i], with: rowArray[i])
            myControllers.append(vc)
        }
    }
        
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TableInDuolarController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.numLabel.text = "\(indexPath.row + 1)"
        cell.descriptionLabel.text = rowArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentPageVC(from: indexPath.row)
    }
    
    func presentPageVC(from: Int) {
        let first = myControllers[from]
        let vc = UIPageViewController(transitionStyle: .pageCurl,
                                      navigationOrientation: .horizontal,
                                      options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first],
                              direction: .forward,
                              animated: true,
                              completion: nil)
        navigationController?.present(vc, animated: true, completion: nil)
    }
}


extension TableInDuolarController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
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
