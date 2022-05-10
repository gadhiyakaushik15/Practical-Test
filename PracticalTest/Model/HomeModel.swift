//
//  HomeModel.swift
//  PracticalTest
//
//  Created by Tej Shah on 2022-05-05.
//

import Foundation

// MARK: - BannerModel
class BannerModel: Codable {
    var errorCode, message: String?
    var data: BannerDataClass?

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - BannerDataClass
class BannerDataClass: Codable {
    var mainBanner, brandZoneBanner, promotionalBanner, promotionalBanner2: [BrandZoneBanner]?
    var recommended: Recommended?
}

// MARK: - BrandZoneBanner
class BrandZoneBanner: Codable {
    var id: Int?
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
    }
}

// MARK: - Recommended
class Recommended: Codable {
    var name: String?
    var productTagID: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case productTagID = "productTagId"
    }
}


// MARK: - ProductListModel
class ProductListModel: Codable {
    var errorCode, message: String?
    var data: ProductListDataClass?

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - ProductListDataClass
class ProductListDataClass: Codable {
    var marketList: [MarketList]?
    var pagination: Pagination?

    enum CodingKeys: String, CodingKey {
        case marketList
        case pagination = "Pagination"
    }
}

// MARK: - MarketList
class MarketList: Codable {
    var productID: Int?
    var name: String?
    var localPrice: Double?
    var imgURL: String?
    var rank: Int?
    var ratingEmoji: String?
    var localCrossedPrice: Int?
    var brand: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case name, localPrice
        case imgURL = "imgUrl"
        case rank, ratingEmoji, localCrossedPrice, brand
    }
}

// MARK: - Pagination
class Pagination: Codable {
    var page, rowsPerPage, totalCount, totalPage: Int?

    init(page: Int?, rowsPerPage: Int?, totalCount: Int?, totalPage: Int?) {
        self.page = page
        self.rowsPerPage = rowsPerPage
        self.totalCount = totalCount
        self.totalPage = totalPage
    }
}
