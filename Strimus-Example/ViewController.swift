//
//  ViewController.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    func showError(_ error: Error) {
        let vc = UIAlertController(title: "Error",
                                   message: error.localizedDescription,
                                   preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(vc, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let vc = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(vc, animated: true)
    }
}

