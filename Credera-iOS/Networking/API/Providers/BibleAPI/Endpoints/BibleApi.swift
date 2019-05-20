//
//  BibleApi.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

protocol BibleApi {
    
    func readBooks() -> Promise<BooksApiModel>
    func readChapters(bookId: String) -> Promise<ChaptersApiModel>
    func readVerses(chapterId: String) -> Promise<VersesApiModel>
    func readVerse(verseId: String) -> Promise<VerseDataApiModel>
    
}
