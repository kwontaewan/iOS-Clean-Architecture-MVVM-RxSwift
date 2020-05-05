//
//  UIImageView+Kingfisher.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/05.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

typealias ImageOptions = KingfisherOptionsInfo

enum ImageResult {
  case success(UIImage)
  case failure(Error)

  var image: UIImage? {
    if case .success(let image) = self {
      return image
    } else {
      return nil
    }
  }

  var error: Error? {
    if case .failure(let error) = self {
      return error
    } else {
      return nil
    }
  }
}

extension UIImageView {
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in // 캐시에서 키를 통해 이미지를 가져온다.
            if let image = image { // 만약 캐시에 이미지가 존재한다면
                self.image = image // 바로 이미지를 셋한다.
            } else {
                // 캐시가 없다면
                guard let url = URL(string: urlString) else {
                    return
                }
                // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                let resource = ImageResource(
                    downloadURL: url,
                    cacheKey: urlString
                )
                self.kf.setImage(with: resource) // 이미지를 셋한다.
            }
        }
    }
}

