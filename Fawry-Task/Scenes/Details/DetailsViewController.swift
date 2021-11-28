//
//  DetailsViewController.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!

    var viewModel: DetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    func setupUI() {
        authorLabel.text = viewModel?.item.author
        authorImage.fromUrlString(urlString: viewModel?.item.downloadURL ?? "") {[weak self] in
            self?.view.backgroundColor = self?.authorImage.image?.averageColor
        }
        self.view.backgroundColor = self.authorImage.image?.averageColor
        authorLabel.textColor = self.view.backgroundColor?.inverted
    }

}
