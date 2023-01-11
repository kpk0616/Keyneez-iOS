//
//  ContentAPI.swift
//  Keyneez
//
//  Created by 박의서 on 2023/01/12.
//

import Foundation
import Moya

enum ContentAPI {
  case getAllContents
  case getDetailContent(param: HomeContentResponseDto)
  case getSearchContent(keyword: String)
  case postLikeContent
  case getLikedContent
}

extension ContentAPI: TargetType {
  var baseURL: URL {
    return URL(string: URLConstant.baseURL)!
  }
  
  var path: String {
    switch self {
    case .getAllContents:
      return URLConstant.content
    case .getDetailContent:
      return URLConstant.contentDetail
    case .getSearchContent:
      return URLConstant.searchContent
    case .postLikeContent:
      return URLConstant.likeContent
    case .getLikedContent:
      return URLConstant.saveContent
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getAllContents,
        .getDetailContent,
        .getSearchContent,
        .getLikedContent:
      return .get
    case .postLikeContent:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .getAllContents:
      return .requestPlain
    case .getDetailContent(let param):
      return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
    case .getSearchContent(let keyword):
      return .requestParameters(parameters: ["keyword": keyword], encoding: JSONEncoding.default)
    case .postLikeContent:
      return .requestPlain
    case .getLikedContent:
      return .requestPlain
    }
  }
  
  var headers: [String: String]? {
    switch self {
    case .getAllContents,
        .getDetailContent,
        .getSearchContent:
      return ["Content-Type": "application/json"]
    default:
      return nil
    }
  }
}