//
//  TongiVaTungiZikrlarController.swift
//  Islamic
//
//  Created by Asliddin Rasulov on 27/10/20.
//

import UIKit

class TongiVaTungiZikrlarController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var database = Database()
    
    var arabicArray: [String] = []
    var transcriptionArray: [String] = []
    var translationArray: [String] = []
    
    var fetchName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = fetchName
        
        arabicArray = database.fetch(name: fetchName, n: 0)
        transcriptionArray = database.fetch(name: fetchName, n: 1)
        translationArray = database.fetch(name: fetchName, n: 2)
        
        collectionView.register(UINib(nibName: "ZikrlarCell", bundle: nil), forCellWithReuseIdentifier: "zikrlarCell")
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension TongiVaTungiZikrlarController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arabicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zikrlarCell", for: indexPath) as! ZikrlarCell
        cell.arabicLabel.text = arabicArray[indexPath.row]
        cell.transcriptionLabel.text = transcriptionArray[indexPath.row]
        cell.translationLabel.text = translationArray[indexPath.row]
        return cell
    }
    
    
}
