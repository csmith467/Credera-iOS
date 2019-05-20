//
//  VerseObjectApiModel.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation

struct VerseObjectApiModel: Codable {
    let id: String?
    let orgId: String?
    let bookId: String?
    let chapterId: String?
    let bibleId: String?
    let reference: String?
    let content: [VerseContentApiModel]?
}
