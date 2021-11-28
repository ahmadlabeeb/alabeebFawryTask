//
//  HomeViewController.swift
//  Fawry-Task
//
//  Created by Labeeb on 27/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let bag = DisposeBag()
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupImagesCollectionView()
    }
    
    func setupUI() {
        let layout = imagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 8
    }
    
    func setupViewModel() {
        viewModel = HomeViewModel.init()
        viewModel.getHomeData()
    }
    
    func setupImagesCollectionView() {
        imagesCollectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        imagesCollectionView.delegate = self
        viewModel?.homeItems
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            
            .drive(imagesCollectionView.rx.items(cellIdentifier: "cell",cellType: ImageCollectionViewCell.self)) { row,element,cell in
                cell.auNameLabel.text = element.author
            }.disposed(by: bag)
    }
    

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let size = CGSize.init(width: width/2.0, height: width/2.0)
        return size
    }
    
}
