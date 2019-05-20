//
//  BibleApiImpl.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

class BibleApiImpl: BibleApi {
    
    private let caller: RequestCaller
    
    init(caller: RequestCaller) {
        self.caller = caller
    }
    
    func readBooks() -> Promise<BooksApiModel> {
        let request = BibleApiRequest(httpMethod: HttpMethod.get, path: "books")
        let response: Promise<BooksApiModel> = caller.call(request)
        return response
    }
    
    func readChapters(bookId: String) -> Promise<ChaptersApiModel> {
        let request = BibleApiRequest(httpMethod: HttpMethod.get, path: "books/\(bookId)/chapters")
        let response: Promise<ChaptersApiModel> = caller.call(request)
        return response
    }
    
    func readVerses(chapterId: String) -> Promise<VersesApiModel> {
        let request = BibleApiRequest(httpMethod: HttpMethod.get, path: "chapters/\(chapterId)/verses")
        let response: Promise<VersesApiModel> = caller.call(request)
        return response
    }
    
    func readVerse(verseId: String) -> Promise<VerseDataApiModel> {
        let request = BibleApiRequest(httpMethod: HttpMethod.get, path: "verses/\(verseId)")
        request.query = ["content-type": "json"]
        let response: Promise<VerseDataApiModel> = caller.call(request)
        return response
    }
    
}
