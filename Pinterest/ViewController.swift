//
//  ViewController.swift
//  Pinterest
//
//  Created by Süleyman Koçak on 29.05.2020.
//  Copyright © 2020 Suleyman Kocak. All rights reserved.
//

import UIKit

class GradientLayer: CAGradientLayer {
   var gradient: (start: CGPoint, end: CGPoint)? {
      didSet {
         startPoint = gradient?.start ?? CGPoint.zero
         endPoint = gradient?.end ?? CGPoint.zero
      }
   }
}

class GradientView: UIView {
   override public class var layerClass: AnyClass {
      return GradientLayer.self
   }
}

protocol GradientViewProvider {
   associatedtype GradientViewType

}
extension GradientViewProvider where Self: UIView {
   var gradientLayer: Self.GradientViewType {
      return layer as! Self.GradientViewType
   }
}

extension UIView: GradientViewProvider {
   typealias GradientViewType = GradientLayer
}

class ViewController: UIViewController {
   private let gradientView: GradientView = {
      let v = GradientView()
      v.gradientLayer.gradient = (start: CGPoint(x: 0.5, y: 1), end: CGPoint(x: 0.5, y: 0))
      v.gradientLayer.colors = [UIColor(white: 1, alpha: 1).cgColor, UIColor(white: 1, alpha: 0).cgColor]
      return v
   }()

   private let headerImageView: UIImageView = {
      let iv = UIImageView(image: UIImage.gifImageWithName("giphy"))
      return iv
   }()
   private let welcomeLabel: UILabel = {
      let label = UILabel()
      label.text = "Welcome to Pinterest"
      label.textColor = .mainGray
      label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
      label.textAlignment = .center
      return label
   }()
   private let logoImageView: UIImageView = {
      let iv = UIImageView()
      iv.image = UIImage(named: "logo")
      iv.layer.zPosition = 1
      return iv
   }()

   private let loginButton: UIButton = {
      let button = UIButton(type: .system)
      button.layer.cornerRadius = 15
      button.clipsToBounds = true
      button.setTitle("Login", for: .normal)
      button.backgroundColor = UIColor.red.withAlphaComponent(0.7)
      button.setTitleColor(.label, for: .normal)
      button.titleLabel?.textAlignment = .center
      button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
      return button
   }()
   private let emailButton: UIButton = {
      let button = UIButton(type: .system)
      button.layer.cornerRadius = 15
      button.clipsToBounds = true
      button.setTitle("Continue with Email", for: .normal)
      button.backgroundColor = .mainRed
      button.setTitleColor(.label, for: .normal)
      button.titleLabel?.textAlignment = .center
      return button
   }()
   private let facebookButton: UIButton = {
      let button = UIButton(type: .system)
      button.layer.cornerRadius = 15
      button.clipsToBounds = true
      button.setTitle("Continue with Facebook", for: .normal)
      button.backgroundColor = .darkBlue
      button.setTitleColor(.label, for: .normal)
      button.titleLabel?.textAlignment = .center
      return button
   }()
   private let googleButton: UIButton = {
      let button = UIButton(type: .system)
      button.layer.cornerRadius = 15
      button.clipsToBounds = true
      button.setTitle("Continue with Google", for: .normal)
      button.backgroundColor = .lightBlue
      button.setTitleColor(.label, for: .normal)
      button.titleLabel?.textAlignment = .center
      return button
   }()
   lazy var buttonStackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [emailButton, facebookButton, googleButton])
      stack.axis = .vertical
      stack.alignment = .fill
      stack.spacing = 10
      stack.distribution = .fillEqually
      stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      return stack
   }()


   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      setupElements()

   }

   func setupElements() {
      [logoImageView, welcomeLabel, loginButton, buttonStackView, headerImageView].forEach { component in
         view.addSubview(component)
         component.translatesAutoresizingMaskIntoConstraints = false
      }
      headerImageView.addSubview(gradientView)
      loginButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 70, paddingRight: 20, height: 50)
      buttonStackView.anchor(left: view.leftAnchor, bottom: loginButton.topAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 40, paddingRight: 20, height: view.frame.height * 0.2)
      welcomeLabel.anchor(left: view.leftAnchor, bottom: buttonStackView.topAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 35, paddingRight: 20)
      logoImageView.anchor(bottom: welcomeLabel.topAnchor, paddingBottom: 20, width: 140, height: 140)
      logoImageView.centerX(inView: view)

      headerImageView.anchor(left: view.leftAnchor, bottom: welcomeLabel.topAnchor, right: view.rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

      gradientView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: headerImageView.bottomAnchor, right: view.rightAnchor)
   }

    //MARK: - Selectors
    @objc func loginButtonPressed(){
        let destinationVC = MainTabBarController()
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC,animated: true,completion: nil)
    }


}
