import UIKit

class DetailViewController: UIViewController {
   var post: Post? {
      didSet {
         imageView.image = post?.image
         titleLabel.text = post?.title
         descriptionLabel.text = post?.description
      }
   }

   lazy var imageView: UIImageView = {
      let iv = UIImageView()
      iv.layer.shadowColor = UIColor.black.cgColor
      iv.layer.shadowOpacity = 0.7
      iv.layer.shadowRadius = 5.0
      iv.layer.shadowOffset = CGSize(width: 0, height: 0)
      iv.layer.masksToBounds = false
      return iv
   }()


   private let titleLabel: UILabel = {
      let label = UILabel()
      label.numberOfLines = 2
      label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
      label.textColor = .mainGray
      return label
   }()
   private let descriptionLabel: UILabel = {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
      label.textColor = .mainGray
      return label
   }()
   private let backButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
      button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
      return button
   }()
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      setupElements()
      view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
   }
   var viewTranslation = CGPoint(x: 0, y: 0)
   @objc func handleDismiss(sender: UIPanGestureRecognizer) {
      switch sender.state {
      case .changed:
         viewTranslation = sender.translation(in: view)
         UIView.animate(
            withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut,
            animations: {
               self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
      case .ended:
         if viewTranslation.y < 200 {
            UIView.animate(
               withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut,
               animations: {
                  self.view.transform = .identity
               })
         } else {
            dismiss(animated: true, completion: nil)
         }
      default:
         break
      }
   }
   @objc func backButtonPressed() {
      dismiss(animated: true, completion: nil)
   }

   func setupElements() {
      view.addSubview(backButton)
      view.addSubview(imageView)
      view.addSubview(titleLabel)
      view.addSubview(descriptionLabel)
      backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 10, width: 38, height: 38)

      imageView.anchor(top: backButton.bottomAnchor, paddingTop: 20, width: view.frame.width * 0.9, height: view.frame.width * 0.5)
      imageView.centerX(inView: view)
      titleLabel.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 18, paddingRight: 18)
      descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 18, paddingRight: 18)
   }



}
