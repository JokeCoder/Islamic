//
//  TextInPageVC.swift
//  Islamic
//
//  Created by coder on 06/11/20.
//

import UIKit

class TextInPageController: UIViewController {
    
    var myText: String
    var titleText: String
    
    let myTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .black

        return textView
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .white
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.6
        title.font = .boldSystemFont(ofSize: 25)
        title.textColor = .black
        title.textAlignment = .center

        return title
    }()
    
    init(with text: String, with title: String) {
        self.myText = text
        self.titleText = title
        myTextView.text = self.myText
        titleLabel.text = self.titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(self.titleLabel)
        view.addSubview(self.myTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.titleLabel.frame = CGRect(x: 5, y: 0, width: self.view.frame.width - 10, height: self.view.frame.height * 0.05)

        self.myTextView.frame = CGRect(x: 5, y: self.view.frame.height * 0.05, width: self.view.frame.width - 10, height: self.view.frame.height * 0.95)
    }
    
    @objc func dismissThePVC() {
        dismiss(animated: true, completion: nil)
    }
    
}
