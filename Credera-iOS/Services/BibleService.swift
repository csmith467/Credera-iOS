//
//  BibleService.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

protocol BibleService {
    
    func getBooks() -> Promise<[Book]>
    func getChapters(bookId: String) -> Promise<[Chapter]>
    func getVerses(chapterId: String) -> Promise<[Verse]>
    func getVerse(verseId: String) -> Promise<Verse>
    
}
