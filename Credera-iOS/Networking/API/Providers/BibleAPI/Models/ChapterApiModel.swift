//
//  ChapterApiModel.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

struct ChapterApiModel: Codable {
    let id: String?
    let bibleId: String?
    let bookId: String?
    let number: String?
    let reference: String?
}
