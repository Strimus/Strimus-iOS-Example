//
//  StreamListViewController.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import UIKit
import MACH_SPS
class StreamListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    private var streams: [SBSStream] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StreamCell", bundle: nil), forCellReuseIdentifier: "StreamCell")
        tableView.estimatedRowHeight = 86
        tableView.dataSource = self
        tableView.delegate = self
        getStreams(type: .live)
    }

    private func getStreams(type: StreamListType) {
        Task {
            segment.isEnabled = false
            if let streams = try? await Strimus.shared.getStreams(type: type) {
                self.streams = streams
                tableView.reloadData()
            }
            segment.isEnabled = true
        }
    }
    
    
    @IBAction func segmentChanged(_ sender: Any) {
        if let segment = sender as? UISegmentedControl {
            segment.selectedSegmentIndex == 0 ? getStreams(type: .live) : getStreams(type: .past)
        }
    }
    
}

extension StreamListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as! StreamCell
        cell.configure(stream: streams[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let stream = streams[indexPath.row]
        let vc = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
        vc.stream = stream
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
