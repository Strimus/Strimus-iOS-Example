//
//  HomeViewController.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import UIKit
import MACH_SPS
class HomeViewController: ViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var authButton: UIButton!
    
    private var authCompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Create Streamer
    @IBAction func registerSelected(_ sender: Any) {
        guard let text = userField.text, !text.isEmpty else { return }
        Task {
            do {
                let result = try await ClientManager.shared.register(uniqueId: text)
                if result {
                    showAlert(title: "Success", message: "New Streamer Created!")
                }
            } catch {
                showError(error)
            }
        }
    }
    
    //Auth
    @IBAction func loginSelected(_ sender: Any) {
        guard authCompleted == false else {
            startBroadcast()
            return
        }
        guard let text = userField.text, !text.isEmpty else { return }
        Task {
            do {
                let result = try await ClientManager.shared.auth(uniqueId: text)
                if result, let token = ClientManager.shared.token, let id = ClientManager.shared.uniqueId {
                    Strimus.shared.setStreamerData(uniqueId: id, streamerToken: token)
                    showAlert(title: "Welcome", message: "Auth Completed!")
                    authButton.setTitle("Start Broadcast", for: .normal)
                    authCompleted = true
                }
            } catch {
                showError(error)
            }
        }
    }
    
    @IBAction func guestSelected(_ sender: Any) {
        let vc = StreamListViewController(nibName: "StreamListViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func startBroadcast() {
        
    }
    
}
