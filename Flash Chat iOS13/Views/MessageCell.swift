//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Artem Shuliak  on 10/31/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
        
    @IBOutlet var stackViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var stackViewLeadingConstraint: NSLayoutConstraint!
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!

    // MARK: -
    
    var isIncoming: Bool?
    var message: Message! {
        didSet {
            label.text = message.body
            if message.sender == Auth.auth().currentUser?.email {
            isIncoming = false
            } else {
            isIncoming = true
            }
            bubblePosition()
        }
    }

    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bubblePosition()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 3
       
        messageBubble.clipsToBounds = true
        trailingConstraint = messageBubble.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -20)
        leadingConstraint = messageBubble.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 20)
    }

    
    func bubblePosition() {
        if isIncoming == false {
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            label.textColor = UIColor(named: K.BrandColors.purple)
            trailingConstraint.isActive = true
            leadingConstraint.isActive = false
            stackViewTrailingConstraint.isActive = true
            stackViewLeadingConstraint.isActive = false
        } else {
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            label.textColor = UIColor(named: K.BrandColors.lighBlue)
            leadingConstraint.isActive = true
            trailingConstraint.isActive = false
            stackViewLeadingConstraint.isActive = true
            stackViewTrailingConstraint.isActive = false
        }
    }
    
}
