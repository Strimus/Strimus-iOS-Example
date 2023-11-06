//
//  PlayerViewController.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import UIKit
import MACH_SPS
import SnapKit

class PlayerViewController: UIViewController {

    private var player = SPSPlayer()
    private var playerView: SPSPlayerView?
    
    var stream: SBSStream?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlayerView()
    }
    
    private func getPlayerView() {
        guard let stream else { return }
        let playerView = player.getPlayerView(stream: stream)
        self.playerView = playerView
        view.addSubview(playerView)
        playerView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        playerView.delegate = self
    }
}
      
 extension PlayerViewController: SPSPlayerDelegate {
    
    func stateUpdated(state: SPSPlayerState) {
        if playerView?.state == .ready {
            playerView?.play()
        }
    }
    
    func playerError(error: Error) {
        print("player error \(error)")
    }
    
}
