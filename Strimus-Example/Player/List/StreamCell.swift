//
//  StreamCell.swift
//  Strimus-Example
//
//  Created by Machinarium on 6.11.2023.
//

import UIKit
import MACH_SPS
import Kingfisher

class StreamCell: UITableViewCell {

    @IBOutlet weak var streamImageView: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    func configure(stream: SBSStream) {
        streamImageView.kf.setImage(with: stream.streamData.image)
        firstLabel.text = stream.streamData.name
        secondLabel.text = stream.type.rawValue
        secondLabel.textColor = stream.type == .live ? .red : .secondaryLabel
    }
}
