//
//  QuoteRepository.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation

class QuoteRepository {
    static let shared = QuoteRepository()
    
    private init() {}
    
    func saveQuote(quote: Quote) {
        let quoteDao = QuoteDao(author: quote.author, content: quote.content)
        do {
            try quoteDao.save()
        } catch {
            print("Failing to save quote: \(quote.content)")
        }
    }
    
    func getAllQuotes(completion: @escaping ([Quote]) -> Void) {
        let query = QuoteDao.query().order([.ascending("createdAt")])
        query.find() { response in
            let quotes: [Quote] = (try? response.get())?.compactMap({
                guard let author = $0.author, let content = $0.content else { return nil }
                return Quote(author: author, content: content)
            }) ?? []
            
            completion(quotes)
            
        }
    }
    
    func deleteQuote(quote: Quote) {
        let quoteDao = QuoteDao(author: quote.author, content: quote.content)
        do {
            try quoteDao.delete()
        } catch {
            print("Failing to delete quote: \(quote.content)")
        }
    }
}
