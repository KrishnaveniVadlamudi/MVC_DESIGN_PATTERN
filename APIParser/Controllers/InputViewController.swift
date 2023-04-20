//
//  InputViewController.swift
//  APIParser
//
//  Created by Sunkara on 4/17/23.
//

import UIKit

class InputViewController: UIViewController {

    
    @IBOutlet weak var enterURLField: UITextField!
    @IBOutlet weak var parseBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enterURLField!.text = "https://dummyjson.com/todos/"
      
    }
    

    @IBAction func parseBtnTapped(_ sender:UIButton) {
        
        if let url = URL(string:"https://dummyjson.com/todos/") {
            launchViewController()
        }
        else {
            print("URL is wrong....")
        }
        
        
    }

    func launchViewController() {
        let storyBrd = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBrd.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController
        guard let vc1 = vc else {return}
        
        vc1.urlStr = enterURLField.text!
        self.navigationController?.pushViewController(vc1, animated: true)
    }
}
