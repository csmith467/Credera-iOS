//
//  BookApiModel.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

struct BookApiModel: Codable {
    let id: String?
    let bibleId: String?
    let abbreviation: String?
    let name: String?
    let nameLong: String?
}
