//
//  BaseViewController.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
      log.verbose("DEINIT: \(self.className)")
    }

    // MARK: Rx
    var disposeBag = DisposeBag()

}
