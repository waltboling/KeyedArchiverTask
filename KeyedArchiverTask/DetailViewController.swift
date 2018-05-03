//
//  DetailViewController.swift
//  KeyedArchiverTask
//
//  Created by Jon Boling on 4/30/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var colorOne: UIView!
    @IBOutlet weak var colorTwo: UIView!
    @IBOutlet weak var mascotImage: UIImageView!
    @IBOutlet weak var detailTitleLabel: UINavigationItem!

    func configureView() {
        if let detail = detailItem {
            if let label = detailTitleLabel {
                label.title = detail.title
            }
            if let topColor = colorOne {
                    topColor.backgroundColor = detail.colorOne
                }
            if let bottomColor = colorTwo {
                    bottomColor.backgroundColor = detail.colorTwo
                }
           if let middleImage = mascotImage {
                    middleImage.image = detail.mascot
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureView()
    }

    var detailItem: Teams? {
        didSet {
            configureView()
        }
    }
}

