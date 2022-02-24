//
//  ViewController.swift
//  BithumbAPITest
//
//  Created by 박형석 on 2022/02/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let bithumbHTTP: BithumbHTTPAPI = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bithumbHTTP.requestAllAssetsStatus()
            .subscribe(onNext: { datas in
                print(datas)
            })
            .disposed(by: self.disposeBag)
    }


}

