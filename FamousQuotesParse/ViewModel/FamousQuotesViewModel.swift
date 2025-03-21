//
//  FamousQuotesViewModel.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import Foundation
import ParseSwift

@Observable
class FamousQuotesViewModel {
    var quotes: [Quote]
    var isShowingAddQuote: Bool
    var newQuoteAuthor: String
    var newQuoteContent: String
    
    init() {
        self.quotes = []
        self.isShowingAddQuote = false
        self.newQuoteAuthor = ""
        self.newQuoteContent = ""
    }
    
    func restoreQuotes() {
        QuoteRepository.shared.getAllQuotes(completion: { quotes in
            self.quotes = quotes
        })
    }
    
    func addNewQuote() {
        let quote = Quote(author: newQuoteAuthor, content: newQuoteContent)
        quotes.append(quote)
        QuoteRepository.shared.saveQuote(quote: quote)
        newQuoteAuthor = ""
        newQuoteContent = ""
        isShowingAddQuote = false
    }
    
    func deleteQuote(quoteToDelete: Quote) {
        QuoteRepository.shared.getAllQuotes(completion: { quotes in
            self.quotes = quotes
        })
        
        for i in 0..<quotes.count {
            if quotes[i].content == quoteToDelete.content {
                QuoteRepository.shared.deleteQuote(quote: quotes[i])
                quotes.remove(at: i)
            }
        }
    }
}
