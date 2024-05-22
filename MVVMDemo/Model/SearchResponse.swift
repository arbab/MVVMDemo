//
//  SearchResponse.swift
//  MVVMDemo
//
//  Created by Arbab Nawaz on 5/8/24.
//

import Foundation


struct SearchResponse: Codable {
    
    let resultCount: Int?
    let results: [SearchResult]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
    
}

struct SearchResult: Codable {
    let trackId: Int?
    let trackName: String?
    let trackViewUrl: String?
    let wrapperType: String?
    let collectionType: String?
    let artistId: Int?
    let collectionId: Int?
    let amgArtistId: Int?
    let artistName: String?
    let collectionName: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let trackCount: Int?
    let copyright: String?
    let country: String?
    let currency: String?
    let releaseDate: String?
    let primaryGenreName: String?
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case trackViewUrl
        case wrapperType
        case collectionType
        case artistId
        case collectionId
        case amgArtistId
        case artistName
        case collectionName
        case collectionCensoredName
        case artistViewUrl
        case collectionViewUrl
        case collectionPrice
        case collectionExplicitness
        case artworkUrl60
        case artworkUrl100
        case trackCount
        case copyright
        case country
        case currency
        case releaseDate
        case primaryGenreName
    }
}

extension SearchResult: Identifiable {
    var id: Int {
        
        return UUID().hashValue
    }
}

#if DEBUG
extension SearchResult {
    public static var mockSearchResult: SearchResult {
        return SearchResult(trackId: 220202,
                            trackName: "Mock Track Name",
                            trackViewUrl: "https://music.apple.com/us/album/mock-track-name/123456789",
                            wrapperType:"collection",
                            collectionType:"Album",
                            artistId :909253,
                            collectionId:906900960,
                            amgArtistId:468749,
                            artistName:"Jack Johnson",
                            collectionName:"Brushfire Fairytales (Remastered) [Bonus Version]",
                            collectionCensoredName:"Brushfire Fairytales (Remastered) [Bonus Version]",
                            artistViewUrl:"https://music.apple.com/us/artist/jack-johnson/909253?uo=4",
                            collectionViewUrl:"https://music.apple.com/us/album/brushfire-fairytales-remastered-bonus-version/906900960?uo=4",
                            collectionPrice: 9.99,
                            collectionExplicitness:"notExplicit",
                            artworkUrl60: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6c/3a/c5/6c3ac504-80fb-a60f-0f9a-09da88b6b3fc/181229100723.jpg/60x60bb.jpg",
                            artworkUrl100:"https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/6c/3a/c5/6c3ac504-80fb-a60f-0f9a-09da88b6b3fc/181229100723.jpg/100x100bb.jpg",
                            trackCount:15,
                            copyright:"℗ 2011 Everloving Records",
                            country:"USA",
                            currency:"USD",
                            releaseDate:"2001-02-06T08:00:00Z",
                            primaryGenreName:"Rock")
    }
}
#endif

