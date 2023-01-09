//
//  UIViewController+Extension.swift
//  Keyneez
//
//  Created by 박의서 on 2023/01/09.
//

import UIKit

extension UIViewController {
  func pushToContentDetailView() {
    let contentDetailViewController = ContentDetailViewController()
    self.navigationController?.pushViewController(contentDetailViewController, animated: true)
  }
}