//
//  SearchResultsRowViewModel.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/16/24.
//

import Foundation

struct SearchResultsRowViewModel {
    let model: SearchResult
    
    var trackName: String {
        return model.trackName ?? ""
    }
    
    var artistName: String {
        return model.artistName ?? ""
    }
    
    var releaseDate: String {
        return model.releaseDate ?? ""
    }
    
    var primaryGenreName: String {
        return model.primaryGenreName ?? ""
    }
    
    var imageURL: URL? {
        return URL(string: model.artworkUrl60 ?? "")
    }
    
    var fullPrice: String {
        guard let gPrice = model.collectionPrice, let Currency = model.currency else {
            return ""
        }
        
        return "Price: " + gPrice.formatted(.currency(code: Currency))
    }
}
