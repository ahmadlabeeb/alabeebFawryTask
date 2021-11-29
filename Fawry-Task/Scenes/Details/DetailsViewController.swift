//
//  DetailsViewController.swift
//  Fawry-Task
//
//  Created by Labeeb on 28/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    private let disposeBag = DisposeBag()
    var viewModel: DetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    func setupUI() {
        authorLabel.text = viewModel?.item.author
        authorImage.fromUrlString(urlString: viewModel?.item.downloadURL ?? "")
        authorImage.rx.observe(UIImage.self, "image")
            .subscribe(onNext: { [weak self] image in
                if let image = image {
                    self?.view.backgroundColor = image.averageColor
                    self?.authorLabel.textColor = self?.view.backgroundColor?.inverted
                }else{
                    self?.view.backgroundColor = .white
                    self?.authorLabel.textColor = .black
                }
            })
            .disposed(by: disposeBag)
    }

}
