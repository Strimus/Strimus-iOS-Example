//
//  BroadcastViewController.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import UIKit
import MACH_SPS
class BroadcastViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var playerView: UIView!
    var source: BroadcastSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let source {
            getBroadcaster(source: source)
        }
    }
    
    private let spsBroadcaster = SPSBroadcaster()
    private var broadcasterView: SPSBroadcasterView?
    
    private func getBroadcaster(source: BroadcastSource) {
        broadcasterView = spsBroadcaster.getBroadcasterView(source: source)
        broadcasterView?.createStream(source: source)
        broadcasterView?.delegate = self
    }
    
    @IBAction func startSelected(_ sender: Any) {
        if broadcasterView?.state == .connected {
            broadcasterView?.stopStream()
        } else {
            broadcasterView?.startStream()
        }
    }
    
}

extension BroadcastViewController: SPSBroadcasterDelegate {
    
    func stateUpdated(state: SPSBroadcasterState) {
        let title = state == .connected ? "Stop" : "Start"
        startButton.setTitle(title, for: .normal)
    }
    
    func streamIsReady(preview: UIView?) {
        guard let preview else { return }
        DispatchQueue.main.async { [weak self] in
            self?.playerView.subviews.forEach({ $0.removeFromSuperview() })
            self?.playerView.addSubview(preview)
            preview.snp.makeConstraints({ make in
                make.edges.equalToSuperview()
            })
        }
    }
    
}
