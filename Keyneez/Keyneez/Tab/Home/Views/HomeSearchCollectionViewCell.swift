//
//  HomeSearchCollectionViewCell.swift
//  Keyneez
//
//  Created by 박의서 on 2023/01/09.
//

import UIKit
import SnapKit
import Then

final class HomeSearchCollectionViewCell: UICollectionViewCell {
  static let identifier = "HomeSearchCollectionViewCell"
  
  private let backgroundImageView: UIImageView = .init()
  private let dateLabel: UILabel = .init().then {
    $0.font = .font(.pretendardSemiBold, ofSize: 14)
    $0.textColor = .gray050
  }
  private let titleLabel: UILabel = .init().then {
    $0.font = .font(.pretendardSemiBold, ofSize: 24)
    $0.textColor = .gray050
  }
  private let likeButton: UIButton = .init().then {
    $0.setImage(UIImage(named: "Property 1=line"), for: .normal)
    $0.setImage(UIImage(named: "Property 1=fill"), for: .selected)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeSearchCollectionViewCell {
  private func setLayout() {
    contentView.addSubviews(dateLabel, titleLabel, likeButton)
    dateLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(19)
      $0.centerX.equalToSuperview()
    }
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(49)
      $0.centerX.equalToSuperview()
    }
    likeButton.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(49)
      $0.centerX.equalToSuperview()
    }
  }
  func bindHomeSearchData(model: HomeSearchModel) {
    dateLabel.text = model.startAt + model.endAt // 이 부분 date 형식 변경
    titleLabel.text = model.contentTitle
  }
}
