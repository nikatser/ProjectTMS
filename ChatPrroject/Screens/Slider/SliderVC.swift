//
//  LoginVC.swift
//  ChatPrroject
//
//  Created by Veronika Katser on 15.01.23.
//

import UIKit

class SliderVC: UIViewController {
    
    var zeroView = ZeroView(jsonName: "zeroView")
    
    //MARK: --Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        var collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black.withAlphaComponent(0.3)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: SliderCell.reuseId)
        
        
        return collectionView
    }()
    
    var pageControll: UIPageControl = {
        var pageControll = UIPageControl(frame: CGRect(x: 0, y: 0, width: 30, height: 10))
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.numberOfPages = 3
        
        return pageControll
    }()
    
    var image: UIImageView = {
        var image = UIImage(named: "Main")
        
        var imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.scalesLargeContentImage = true
        
        return imageView
    }()
    
    var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello!"
        label.textColor = Constant.shared.mainColor
        label.font = UIFont(name: Constant.shared.mainNameFont, size: 80)
        label.numberOfLines = 0
        label.textAlignment = .right
        
        return label
    }()
    
    //MARK: -- Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        view.addSubview(image)
        view.addSubview(collectionView)
        view.addSubview(label)
        view.addSubview(pageControll)
        view.addSubview(zeroView)
    }
    
    func setupConstraints(){
        
        zeroView.pinEdgesToSuperView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.zeroView.hide()
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            image.leftAnchor.constraint(equalTo: view.leftAnchor,constant: -5),
            image.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 5),
            image.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            pageControll.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            pageControll.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    @objc
    func login() {
        let nextVC = AuthVC()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
    @objc
    func join() {
        let nextVC = RegisterVC()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControll.currentPage = indexPath.item
    }
}

//MARK: -- Extension

extension SliderVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCell.reuseId, for: indexPath) as! SliderCell
        cell.textLabel.text = SliderItem.descriptionLabelText[indexPath.item]
        if indexPath.item == 2 {
            cell.loginButton.isHidden = false
            cell.joinButton.isHidden = false
            cell.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
            cell.joinButton.addTarget(self, action: #selector(join), for: .touchUpInside)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}
