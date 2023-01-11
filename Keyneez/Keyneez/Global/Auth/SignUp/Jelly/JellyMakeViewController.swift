//
//  MakeJellyViewController.swift
//  Keyneez
//
//  Created by 최효원 on 2023/01/07.
//

import UIKit
import SnapKit
import Then

// MARK: - 네비게이션 추가

class JellyMakeViewController: NiblessViewController {
  
  // MARK: - UI Components
  
  private lazy var titleLabel: UILabel = .init().then {
    $0.text = "나의 젤리 만들기"
    $0.font = UIFont.font(.pretendardBold, ofSize: 24)
  }
  private lazy var subTitleLabel: UILabel = .init().then {
    $0.text = "나의 마음에서 태어날 젤리와\n더욱 다채로운 일상을 함께해요!"
    $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
    $0.textColor = .gray500
    $0.numberOfLines = 0
  }
  private lazy var jellyImageView: UIImageView = .init().then {
    $0.image = UIImage(named: "jelly")
  }
  private lazy var startButton: UIButton = .init(primaryAction: nil).then {
    $0.keyneezButtonStyle(style: .blackAct, title: "시작하기")
    $0.addTarget(self, action: #selector(touchUpNextVC), for: .touchUpInside)
  }
  
  @objc
  private func touchUpNextVC() {
    pushToNextVC(VC: PropensityTagViewController())
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setConfig()
    setLayout()
  }
}

// MARK: - Extensions

extension JellyMakeViewController {
  
  // MARK: - Layout Helpers
  
  private func setConfig() {
    self.view.backgroundColor = .gray050
    [titleLabel, subTitleLabel, jellyImageView, startButton].forEach {
      view.addSubview($0)
    }
  }
  private func setLayout() {
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(SignUpConstant.labelTopExpand)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(SignUpConstant.labelLeading)
    }
    subTitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(SignUpConstant.labelTop)
      $0.leading.equalTo(titleLabel)
    }
    jellyImageView.snp.makeConstraints {
      $0.top.equalTo(subTitleLabel.snp.bottom).offset(SignUpConstant.imageTop)
      $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(SignUpConstant.jellyImageWidth)
      $0.height.equalTo(SignUpConstant.jellyImageHeight)
    }
    startButton.snp.makeConstraints {
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(SignUpConstant.buttonBottom.adjusted)
      $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(SignUpConstant.labelTop)
      $0.height.equalTo(SignUpConstant.buttonHeight.adjusted)
    }
    
  }
}