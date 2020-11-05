//
//  DetailsPageViewControllerInIslom.swift
//  Islamic
//
//  Created by coder on 05/11/20.
//

import UIKit

class DetailsPageViewControllerInIslom: UIPageViewController {

    weak var swipeDelegate: PageViewControllerDelegate?
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

protocol PageViewControllerDelegate: class {
    func pageDidSwipe(to index: Int)
}
