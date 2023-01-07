//
//  HomeViewController.swift
//  Keyneez
//
//  Created by 박의서 on 2023/01/02.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: NiblessViewController, NavigationBarProtocol {
  
  // MARK: - NavagationView with logo
  lazy var navigationView: UIView = NavigationViewBuilder(barViews: [.logo, .flexibleBox, .iconButton(with: searchButton)]).build()
  private lazy var searchButton: UIButton = .init(primaryAction: didSearch).then {
    $0.setBackgroundImage(UIImage(named: "ic_search"), for: .normal)
  }
  private var didSearch: UIAction = .init(handler: { _ in print("hi")})
  lazy var contentView: UIView = UIView()
  
  // MARK: - SegmentedControl Control
  private lazy var containerView: UIView = .init().then {
    $0.backgroundColor = .clear
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  private lazy var segmentControl: UISegmentedControl = .init().then {
    $0.selectedSegmentTintColor = .clear
    $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
    $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    $0.insertSegment(withTitle: "추천", at: 0, animated: true)
    $0.insertSegment(withTitle: "인기", at: 1, animated: true)
    $0.insertSegment(withTitle: "최신", at: 2, animated: true)
    $0.selectedSegmentIndex = 0
    $0.setTitleTextAttributes([
      NSAttributedString.Key.foregroundColor: UIColor.gray400,
      NSAttributedString.Key.font: UIFont.font(.pretendardMedium, ofSize: 24)
    ], for: .normal)
    $0.setTitleTextAttributes([
      NSAttributedString.Key.foregroundColor: UIColor.gray900,
      NSAttributedString.Key.font: UIFont.font(.pretendardBold, ofSize: 24)
    ], for: .selected)
    $0.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  // MARK: - Underline View
  private lazy var underLineView: UIView = .init().then {
    $0.backgroundColor = .gray900
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLayout()
    addContentViews(asChildViewController: RecommendCollectionViewController())
    addNavigationViewToSubview()
  }
}

// MARK: - extra functions
extension HomeViewController {
  private func setLayout() {
    contentView.addSubviews(containerView)
    containerView.addSubviews(segmentControl, underLineView)
    containerView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(48)
    }
    segmentControl.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().offset(2)
    }
    underLineView.snp.makeConstraints {
      $0.bottom.equalTo(segmentControl).offset(6)
      $0.leading.equalTo(segmentControl).inset(15)
      $0.height.equalTo(3)
      $0.width.equalTo(32)
    }
  }
  @objc private func changeUnderLinePosition() {
    let segmentIndex = segmentControl.selectedSegmentIndex
    let segmentNumber = segmentControl.numberOfSegments
    self.underLineView.snp.remakeConstraints {
      $0.bottom.equalTo(segmentControl).offset(6)
      $0.leading.equalTo(segmentControl).inset(Int(self.segmentControl.frame.width) / segmentNumber * segmentIndex + 15)
      $0.height.equalTo(3)
      $0.width.equalTo(32)
    }
    UIView.animate(withDuration: 0.2, animations: { [weak self] in
      self?.view.layoutIfNeeded()
    })
  }
  private func addContentViews(asChildViewController viewController: UIViewController) {
    addChild(viewController)
    let subView = viewController.view!
    contentView.addSubview(subView)
    subView.snp.makeConstraints {
      $0.top.equalTo(underLineView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    viewController.didMove(toParent: self)
  }
}
