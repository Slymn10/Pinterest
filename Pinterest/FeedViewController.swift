//
//  FeedViewController.swift
//  Pinterest
//
//  Created by Süleyman Koçak on 30.05.2020.
//  Copyright © 2020 Suleyman Kocak. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

   lazy var collectionView: UICollectionView = {
      let layout = PinterestLayout()
      layout.delegate = self
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      cv.register(PinterestCell.self, forCellWithReuseIdentifier: "cellID")
      cv.backgroundColor = .clear
      cv.showsVerticalScrollIndicator = false
      cv.contentInset.top = 5
      return cv
   }()
   let posts = PostProvider.GetPosts()

   private let searchTF: UITextField = {
      let tf = UITextField()
      tf.placeholder = "Search"
      tf.textAlignment = .center
      tf.backgroundColor = .offWhite
      tf.clipsToBounds = true
      tf.layer.cornerRadius = 10


      let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 25))
      let rightButton = UIButton(type: .custom)
      rightButton.setImage(UIImage(named: "camera-icon")!.withRenderingMode(.alwaysOriginal), for: .normal)
      rightView.addSubview(rightButton)
      rightButton.anchor(right: rightView.rightAnchor, paddingRight: 13, width: 25, height: 25)
      rightButton.centerY(inView: rightView)
      tf.rightView = rightView
      tf.rightViewMode = .always

      let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 25))
      let leftButton = UIButton(type: .system)
      leftButton.setImage(UIImage(named: "search-icon")!.withRenderingMode(.alwaysOriginal), for: .normal)
      leftView.addSubview(leftButton)
      leftButton.anchor(left: leftView.leftAnchor, paddingLeft: 13, width: 17, height: 17)
      leftButton.centerY(inView: leftView)
      tf.leftView = leftView
      tf.leftViewMode = .always
      return tf
   }()
   private let chatButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(named: "chatbubble")?.withRenderingMode(.alwaysOriginal), for: .normal)
      return button
   }()

   override func viewDidLoad() {
      super.viewDidLoad()
      collectionView.delegate = self
      collectionView.dataSource = self
      view.backgroundColor = .systemBackground
      setupNavBar()
      view.addSubview(collectionView)
      collectionView.addConstraintsToFillView(view)
   }
   public func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
         UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.alpha = 1
            self.navigationController?.navigationBar.isHidden = false
            //UP
//            self.navigationController?.navigationBar.frame.origin.y = 40
//            self.navigationController?.navigationBar.isHidden = false
            //self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height - 70
            self.tabBarController?.tabBar.alpha = 1
         }
      } else {
        //DOWN
         UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.alpha = 0
            self.navigationController?.navigationBar.isHidden = true
//            self.navigationController?.navigationBar.frame.origin.y = -50
//            self.navigationController?.navigationBar.isHidden = true
            //self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height
            self.tabBarController?.tabBar.alpha = 0
         }
      }
   }

   func setupNavBar() {
      guard let navBar = navigationController?.navigationBar else { return }
      navBar.isTranslucent = false
      navBar.backgroundColor = .systemBackground
      navBar.addSubview(searchTF)
      navBar.addSubview(chatButton)
      chatButton.anchor(right: navBar.rightAnchor, paddingRight: 18, width: 25, height: 25)
      chatButton.centerY(inView: navBar)
      searchTF.anchor(top: navBar.topAnchor, left: navBar.leftAnchor, bottom: navBar.bottomAnchor, right: chatButton.leftAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 18)
   }

}
extension FeedViewController: PinterestLayoutDelegate {
   func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
      return posts[indexPath.row].image.size.height / 4
   }


}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return posts.count
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? PinterestCell {
         cell.mainImageView.image = posts[indexPath.row].image
         return cell
      }
      return UICollectionViewCell()
   }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            let vc = DetailViewController()
        if let pinterestCell = collectionView.cellForItem(at: indexPath) as? PinterestCell{
            vc.cc_setZoomTransition(originalView: pinterestCell.mainImageView)
            let i : UIImage = posts[indexPath.row].image
            vc.post = Post(image: i, title: posts[indexPath.row].title, description: posts[indexPath.row].description)

        }
        self.present(vc,animated: true,completion: nil)

        return false
    }

}

class PinterestCell: UICollectionViewCell {



   let mainImageView: UIImageView = {
      let iv = UIImageView()
      iv.clipsToBounds = true
      iv.layer.cornerRadius = 8
      iv.contentMode = .scaleAspectFill
      return iv
   }()
   private let moreImageView: UIImageView = {
      let iv = UIImageView()
      iv.image = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
      iv.tintColor = .lightGray
      return iv
   }()

   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .clear

      addSubview(mainImageView)
      addSubview(moreImageView)
      mainImageView.anchor(top: topAnchor, left: leftAnchor, bottom: moreImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
      moreImageView.anchor(bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
   }

   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }

}
