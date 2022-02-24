//
//  BithumbHTTPAPI.swift
//  BithumbAPITest
//
//  Created by 박형석 on 2022/02/24.
//

import Foundation
import Moya
import Alamofire
import RxSwift
import RxCocoa

final class BithumbHTTPAPI {
    let provider = MoyaProvider<BithumbHTTPRouter>()
    
    func requestAllAssetsStatus() -> Observable<[AssetsStatus]> {
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            self.provider.request(.requestAllAssetsStatus) { result in
                switch result {
                case .success(let moyaResponse):
                    guard let response = try? JSONDecoder().decode(HTTPResponse<[String:AssetsStatus]>.self, from: moyaResponse.data),
                          let datums = response.data,
                          response.status == "0000" else {
                              print("⛔️ response or status error")
                              return
                          }
                    var assets = [AssetsStatus]()
                    for value in datums.values {
                        assets.append(value)
                    }
                    observer.onNext(assets)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
