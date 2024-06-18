//
//  ViewController.swift
//  Project
//
//  Created by mac033 on 6/18/24.
//

//import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var setAnimalType: UIButton!
    
    private var animalnum:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setanimalButton()
        // Do any additional setup after loading the view.
    }
    
    func setanimalButton() {
        setAnimalType.menu = UIMenu(children : [
            UIAction(title: "개", handler: {_ in self.animalnum = 1}),
            UIAction(title: "고양이", handler: {_ in self.animalnum = 2})
        ])
        
        setAnimalType.showsMenuAsPrimaryAction = true
        setAnimalType.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func showImg(_ sender: UIButton) {
        guard let animalViewController = self.storyboard?.instantiateViewController(withIdentifier: "animalViewController") as? AnimalViewController else { return }
                // 화면 전환 애니메이션 설정
            animalViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
            animalViewController.modalPresentationStyle = .fullScreen
            animalViewController.animatype = self.animalnum
            
        self.present(animalViewController, animated: true, completion: nil)
    }
    

}
