//
//  TextInPageVC.swift
//  Islamic
//
//  Created by coder on 06/11/20.
//

import UIKit

class TextInPageVC: UIViewController {
    
//    var textViewText: String = ""
    var myText: String
    var titleText: String
    
//    @IBOutlet weak var navTitleOutlet: UILabel!
//    @IBOutlet weak var textViewOutlet: UITextView!
    
//    @IBAction func back(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
//    }
    
    let myTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 22)
        textView.textColor = .black

        return textView
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = .white
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.6
        title.font = .boldSystemFont(ofSize: 28)
        title.textColor = .black
        title.textAlignment = .center

        return title
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(dismissThePVC), for: .touchUpInside)
        return button
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
    
//    init(textViewText: String, titleText: String) {
//        super.init(nibName: nil, bundle: nil)
//        self.textViewText = textViewText
//        self.titleText = titleText
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.textViewOutlet.text = textViewText
//        self.navTitleOutlet.text = titleText
        view.addSubview(self.titleLabel)
        view.addSubview(self.dismissButton)
        view.addSubview(self.myTextView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.titleLabel.frame = CGRect(x: 0, y: 0,
                                       width: self.view.frame.width * 0.8,
                                       height: 50)
        self.dismissButton.frame = CGRect(x: self.view.frame.width * 0.8, y: 0,
                                          width: self.view.frame.width * 0.2,
                                          height: 50)
        self.myTextView.frame = CGRect(x: 0, y: 50,
                                       width: self.view.frame.width,
                                       height: self.view.frame.height - 50)
    }
    
    @objc func dismissThePVC() {
        dismiss(animated: true, completion: nil)
    }
    
}
