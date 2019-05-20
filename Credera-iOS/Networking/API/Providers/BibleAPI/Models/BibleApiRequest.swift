//
//  BibleApiRequest.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

class BibleApiRequest: HttpRequest {
    
    init(httpMethod: HttpMethod, path: String) {
        super.init(httpMethod: httpMethod, path: path, baseUrl: ApiProviderConfig.bibleUrl, headers: ["api-key": ApiProviderConfig.bibleApiKey])
    }
    
    override func isValid() -> Bool {
        return super.isValid() && self.httpMethod != HttpMethod.patch
    }
}
