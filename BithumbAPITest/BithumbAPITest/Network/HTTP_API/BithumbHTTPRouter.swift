//
//  BithumbHTTPRouter.swift
//  BithumbAPITest
//
//  Created by 박형석 on 2022/02/24.
//

import Foundation
import Moya
import Alamofire

enum BithumbHTTPRouter {
    case requestAllAssetsStatus
}

extension BithumbHTTPRouter: TargetType {
    var baseURL: URL {
        switch self {
        case .requestAllAssetsStatus:
            return URL(string: "https://api.bithumb.com/public/assetsstatus")!
        }
    }
    
    var path: String {
        switch self {
        case .requestAllAssetsStatus:
            return "/ALL"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestAllAssetsStatus:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .requestAllAssetsStatus:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "Accept": "application/json"
        ]
    }
    
}

