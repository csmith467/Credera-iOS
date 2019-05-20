//
//  BibleServiceImpl.swift
//  Credera-iOS
//
//  Created by Craig Smith on 5/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import Promises

class BibleServiceImpl: BibleService {
    
    let bibleApi: BibleApi
    
    init(bibleApi: BibleApi) {
        self.bibleApi = bibleApi
    }
    
    func getBooks() -> Promise<[Book]> {
        let apiResponse: Promise<BooksApiModel> = bibleApi.readBooks()
        return apiResponse.then { (books) -> [Book] in
            
            let mapped = books.data?.map({ (apiModel) -> Book in
                var book = Book()
                book.id = apiModel.id ?? ""
                book.name = apiModel.name ?? ""
                book.abbreviation = apiModel.abbreviation ?? ""
                return book
            })
            
            return mapped ?? [Book]()
        }
    }
    
    func getChapters(bookId: String) -> Promise<[Chapter]> {
        let apiResponse: Promise<ChaptersApiModel> = bibleApi.readChapters(bookId: bookId)
        return apiResponse.then { (chapters) -> [Chapter] in
            
            let mapped = chapters.data?.map({ (apiModel) -> Chapter in
                var chapter = Chapter()
                chapter.id = apiModel.id ?? ""
                chapter.bookId = apiModel.bookId ?? ""
                chapter.number = apiModel.number ?? ""
                chapter.reference = apiModel.reference ?? ""
                return chapter
            })
            
            return mapped ?? [Chapter]()
        }
    }
    
    func getVerses(chapterId: String) -> Promise<[Verse]> {
        let apiResponse: Promise<VersesApiModel> = bibleApi.readVerses(chapterId: chapterId)
        return apiResponse.then { (verses) -> [Verse] in
            
            let mapped = verses.data?.map({ (apiModel) -> Verse in
                var verse = Verse()
                verse.id = apiModel.id ?? ""
                verse.bookId = apiModel.bookId ?? ""
                verse.chapterId = apiModel.chapterId ?? ""
                verse.reference = apiModel.reference ?? ""
                return verse
            })
            
            return mapped ?? [Verse]()
        }
    }
    
    func getVerse(verseId: String) -> Promise<Verse> {
        let apiResponse: Promise<VerseDataApiModel> = bibleApi.readVerse(verseId: verseId)
        return apiResponse.then { (verse) -> Verse in
            
            var mappedVerse = Verse()
            mappedVerse.id = verse.data?.id ?? ""
            mappedVerse.bookId = verse.data?.bookId ?? ""
            mappedVerse.chapterId = verse.data?.chapterId ?? ""
            mappedVerse.reference = verse.data?.reference ?? ""
            
            if let verseContent = verse.data?.content {
                if let verseItems = verseContent[0].items {
                    if let verseText = verseItems.first(where: { $0.text != nil})?.text {
                        mappedVerse.text = verseText
                    }
                }
            }
            
            return mappedVerse
        }
    }
    
}
