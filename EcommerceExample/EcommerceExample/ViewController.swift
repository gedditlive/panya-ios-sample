//
//  ViewController.swift
//  EcommerceExample
//
//  Created by Romain Asnar on 3/25/20.
//  Copyright © 2020 Geddit. All rights reserved.
//

import UIKit
import GedditCommerceSDK

class ViewController: UIViewController {

  var presentedDetailsController: UINavigationController?
  var dismissAction: (()->())?
  
  override func viewDidLoad() {
    print(GedditLiveCommerce.sdkVersion)
    super.viewDidLoad()
  }

  @IBAction func openSDK() {
    let userSettings = UserSettings(userId: "snt-1", name: "Rathakit", currency: "THB")
    let sdk = GedditLiveCommerce(appId: "36f08623-ecc2-459a-8396-b6e92e020f70", appSecret: "3ba86d94b39f0e3c6e90c55c931c5c2990521a39f51b652630b7b3a5e943a32f960fad7d", userSettings: userSettings, verbose: true, delegate: self, pipDelegate: self)
    sdk.present(from: self)
  }
}

extension ViewController: GedditCommerceSDKDelegate {
  
  func makeClientController(product id: String) -> UIViewController {
    let vc = UIViewController()
    let label = UILabel()
    label.font = .systemFont(ofSize: 24.0)
    label.textAlignment = .center
    label.text = "Product ID: #\(id)"
    label.textColor = .black
    vc.view.addSubviewAndFit(label)
    vc.view.backgroundColor = .white
    
    addCloseButton(action: #selector(closeProductDetails), to: vc.view)
    addOpenButton(action: #selector(showNextModalController), to: vc.view)
    addTogglePIPButton(action: #selector(togglePIP), to: vc.view)
    addNextButton(action: #selector(showNextController), to: vc.view)
    
    return vc
  }
  
  @discardableResult func addCloseButton(action: Selector, to view: UIView) -> UIButton {
    let button = UIButton()
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    button.setTitle("X", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    return button
  }
  
  @discardableResult func addNextButton(action: Selector, to view: UIView) -> UIButton {
    let button = UIButton()
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 88.0).isActive = true
    button.setTitle("Next", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    return button
  }
  
  @discardableResult func addOpenButton(action: Selector, to view: UIView) -> UIButton {
    let button = UIButton()
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
    button.setTitle("Open", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    return button
  }
  
  @discardableResult func addTogglePIPButton(action: Selector, to view: UIView) -> UIButton {
    let button = UIButton()
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 44.0).isActive = true
    button.setTitle("PIP", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: action, for: .touchUpInside)
    return button
  }
  
  func viewController(for product: Product, dismiss: @escaping ()->()) -> UIViewController {
    dismissAction = dismiss
    let vc = makeClientController(product: product.clientProductId)
    return vc
  }
  
  @objc func closeProductDetails() {
    dismissAction?()
  }
  
  func presentViewController(for product: Product, from: UIViewController) {
    let vc = makeClientController(product: product.clientProductId)
    vc.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closePopupDetails))
    let nc = UINavigationController(rootViewController: vc)
    nc.modalPresentationStyle = .fullScreen
    from.present(nc, animated: true, completion: nil)
    presentedDetailsController = nc
  }
  
  
  @objc func closePopupDetails() {
    presentedDetailsController?.dismiss(animated: true, completion: nil)
  }
}

extension ViewController {
  
  func nextController() -> UIViewController{
    let vc = UIViewController()
    vc.view.backgroundColor = .red
    
    addCloseButton(action: #selector(closeNextController), to: vc.view)
    addOpenButton(action: #selector(showNextModalController), to: vc.view)
    addNextButton(action: #selector(showNextController), to: vc.view)
    addTogglePIPButton(action: #selector(togglePIP), to: vc.view)
    return vc
  }
  
  @objc func showNextModalController() {
    let vc = nextController()
    let nc = UINavigationController(rootViewController: vc)
    GedditLiveCommerce.shared?.presentViewController(nc, animated: true)
  }
  
  @objc func showNextController(_ button: UIButton) {
    let vc = nextController()
    button.findViewController()?.navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func closeNextController() {
    GedditLiveCommerce.shared?.dismissViewController(completion: {
      
    })
  }
  
  @objc func togglePIP() {
    GedditLiveCommerce.shared?.togglePIP()
  }
}


extension UIView {
  func findViewController() -> UIViewController? {
    if let nextResponder = self.next as? UIViewController {
      return nextResponder
    } else if let nextResponder = self.next as? UIView {
      return nextResponder.findViewController()
    } else {
      return nil
    }
  }
}

extension ViewController: GedditCommerceSDKPIPDelegate {
  func pipCloseTapped() {
    GedditLiveCommerce.shared?.dismiss() {
      print("Optional callback on SDK dismissed")
    }
  }
  
  func pipTapped() {
    GedditLiveCommerce.shared?.popToLiveStreamController() {
      print("Optional callback on live stream appeared")
    }
  }
}
